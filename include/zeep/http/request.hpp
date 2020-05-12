// Copyright Maarten L. Hekkelman, Radboud University 2008-2013.
//        Copyright Maarten L. Hekkelman, 2014-2019
//  Distributed under the Boost Software License, Version 1.0.
//     (See accompanying file LICENSE_1_0.txt or copy at
//           http://www.boost.org/LICENSE_1_0.txt)

#pragma once

/// \file
/// definition of the zeep::http::request class encapsulating a valid HTTP request

#include <vector>
#include <istream>

#include <boost/asio/buffer.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

#include <zeep/http/header.hpp>

namespace zeep::http
{

/// \brief The supported HTTP methods in libzeep, admittedly a bit limited
enum class method_type
{
	UNDEFINED, OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, CONNECT
};

/// \brief return the text representation of the \a method
inline constexpr const char* to_string(method_type method)
{
	switch (method)
	{
		case method_type::UNDEFINED:	return "UNDEFINED";
		case method_type::OPTIONS:		return "OPTIONS";
		case method_type::GET:			return "GET";
		case method_type::HEAD:			return "HEAD";
		case method_type::POST:			return "POST";
		case method_type::PUT:			return "PUT";
		case method_type::DELETE:		return "DELETE";
		case method_type::TRACE:		return "TRACE";
		case method_type::CONNECT:		return "CONNECT";
		default:						assert(false); return "ERROR";
	}
}

// --------------------------------------------------------------------
// TODO: one day this should be able to work with temporary files

/// \brief container for file parameter information
///
/// Files submitted using multipart/form-data contain a filename and
/// mimetype that might be interesting to the client.
struct file_param
{
	std::string filename;
	std::string mimetype;
	const char* data;
	size_t length;

	explicit operator bool() const
	{
		return data != nullptr;
	}
};

// --------------------------------------------------------------------

/// request contains the parsed original HTTP request as received
/// by the server.

struct request
{
	using param = header;	// alias name
	using cookie_directive = header;	

	method_type method;		///< POST, GET, etc.
	std::string uri;		///< The uri as requested
	int http_version_major; ///< HTTP major number (usually 1)
	int http_version_minor; ///< HTTP major number (0 or 1)
	std::vector<header>
		headers;		  ///< A list with zeep::http::header values
	std::string payload;  ///< For POST requests
	bool close;			  ///< Whether 'Connection: close' was specified
	std::string username; ///< The authenticated user for this request (filled in by webapp::validate_authentication)

	// for redirects...
	std::string local_address; ///< The address the request was received upon
	unsigned short local_port; ///< The port number the request was received upon

	/// \brief Return the time at which this request was received
	boost::posix_time::ptime get_timestamp() const { return m_timestamp; }

	/// \brief Reinitialises request and sets timestamp
	void clear();

	/// \brief Return the value in the Accept header for type
	float get_accept(const char* type) const;

	/// \brief Check for Connection: keep-alive header
	bool keep_alive() const;				 

	/// \brief Set or replace a named header
	void set_header(const char* name, const std::string& value);

	/// \brief Return the named header
	std::string get_header(const char* name) const;

	/// \brief Remove this header from the list of headers
	void remove_header(const char* name);

	/// \brief Return the (reconstructed) request line
	std::string get_request_line() const;

	/// \brief Return the path part of the requested URI
	std::string get_pathname() const
	{
		auto s = uri.find('?');
		return s == std::string::npos ? uri : uri.substr(0, s);
	}

	/// \brief Return the named parameter
	///
	/// Fetch parameters from a request, either from the URL or from the payload in case
	/// the request contains a url-encoded or multi-part content-type header
	std::string get_parameter(const char* name) const
	{
		std::string result;
		std::tie(result, std::ignore) = get_parameter_ex(name);
		return result;
	}

	/// \brief Return the value of the parameter named \a name or the \a defaultValue if this parameter was not found
	std::string get_parameter(const char* name, const std::string& defaultValue) const
	{
		std::string result = get_parameter(name);
		if (result.empty())
			result = defaultValue;
		return result;
	}

	/// \brief Return the value of the parameter named \a name or the \a defaultValue if this parameter was not found
	template<typename T, typename std::enable_if_t<std::is_floating_point_v<T>, int> = 0>
	T get_parameter(const char* name, const T& defaultValue) const
	{
		return static_cast<T>(std::stod(get_parameter(name, std::to_string(defaultValue))));
	}

	/// \brief Return the value of the parameter named \a name or the \a defaultValue if this parameter was not found
	template<typename T, typename std::enable_if_t<std::is_integral_v<T> and not std::is_same_v<T,bool>, int> = 0>
	T get_parameter(const char* name, const T& defaultValue) const
	{
		return static_cast<T>(std::stol(get_parameter(name, std::to_string(defaultValue))));
	}

	/// \brief Return the value of the parameter named \a name or the \a defaultValue if this parameter was not found
	template<typename T, typename std::enable_if_t<std::is_same_v<T,bool>, int> = 0>
	T get_parameter(const char* name, const T& defaultValue) const
	{
		auto v = get_parameter(name, std::to_string(defaultValue));
		return v == "true" or v == "1";
	}

	/// \brief Return a std::multimap of name/value pairs for all parameters
	std::multimap<std::string,std::string> get_parameters() const;

	/// \brief Return the info for a file parameter with name \a name
	///
	/// for now we only support a single file per parameter
	/// TODO: implement multi file upload support
	file_param get_file_parameter(const char* name) const;

	/// \brief Return whether the named parameter is present in the request
	bool has_parameter(const char* name) const
	{
		bool result;
		tie(std::ignore, result) = get_parameter_ex(name);
		return result;
	}

	/// \brief Return the value of HTTP Cookie with name \a name
	std::string get_cookie(const char* name) const;

	/// \brief Return the value of HTTP Cookie with name \a name
	std::string get_cookie(const std::string& name) const
	{
		return get_cookie(name.c_str());
	}

	/// \brief Set the value of HTTP Cookie with name \a name to \a value
	void set_cookie(const char* name, const std::string& value);

	/// \brief Return the content of this request in a sequence of const_buffers
	///
	/// Can be used in code that sends HTTP requests
	std::vector<boost::asio::const_buffer> to_buffers();

	/// \brief Return the Accept-Language header value in the request as a std::locale object
	std::locale& get_locale() const;

	/// \brief For debugging purposes
	friend std::iostream& operator<<(std::iostream& io, request& req);

  private:
	std::tuple<std::string,bool> get_parameter_ex(const char* name) const;

	std::string m_request_line;
	boost::posix_time::ptime m_timestamp;
	mutable std::unique_ptr<std::locale> m_locale;
};

} // namespace zeep::http
