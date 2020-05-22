// Copyright Maarten L. Hekkelman, Radboud University 2008-2013.
//        Copyright Maarten L. Hekkelman, 2014-2020
//  Distributed under the Boost Software License, Version 1.0.
//     (See accompanying file LICENSE_1_0.txt or copy at
//           http://www.boost.org/LICENSE_1_0.txt)

#pragma once

/// \file
/// definition of the zeep::http::server class

#include <zeep/config.hpp>

#include <thread>
#include <mutex>

#include <boost/asio.hpp>

#include <zeep/http/request.hpp>
#include <zeep/http/reply.hpp>

namespace zeep::http
{

class connection;
class controller;
class security_context;
class error_handler;

/// \brief The libzeep HTTP server implementation. Originally based on example code found in boost::asio.
///
/// The server class is a simple, stand alone HTTP server. Call bind to make it listen to an address/port
/// combination. Add controller classes to do the actual work. These controllers will be tried in the order
/// at which they were added to see if they want to process a request.

class server
{
  public:

	/// \brief Simple server, no security
	server();

	/// \brief server with a security context for limited access
	server(security_context* s_ctxt);

	server(const server&) = delete;
	server& operator=(const server&) = delete;

	/// \brief Add controller to the list of controllers
	///
	/// When a request is received, the list of controllers get a chance
	/// of handling it, in the order of which they were added to this server.
	/// If none of the controller handle the request the not_found error is returned.
	void add_controller(controller* c);

	/// \brief Add an error handler
	///
	/// Errors are handled by the error handler list. The last added handler
	/// is called first.
	void add_error_handler(error_handler* eh);

	/// \brief Get the security context provided in the constructor
	security_context& get_security_context() 		{ return *m_security_context; }

	/// \brief Return the credentials, if there is a security context and the request contains a valid authentication
	json::element get_credentials(const request& req) const;

	/// \brief Bind the server to address \a address and port \a port
	virtual void bind(const std::string& address, unsigned short port);

	virtual ~server();

	/// \brief Set whether to add a csrf-token Cookie to the session, default is false
	void set_add_csrf_token(bool b);

	/// \brief Run as many as \a nr_of_threads threads simultaneously
	virtual void run(int nr_of_threads);

	/// \brief Stop all threads and stop listening
	virtual void stop();

	/// \brief to extend the log entry for a current request, use this ostream:
	static std::ostream& get_log();

	/// \brief log_forwarded tells the HTTP server to use the last entry in X-Forwarded-For as client log entry
	void set_log_forwarded(bool v) { m_log_forwarded = v; }

	/// \brief returns the address as specified in bind
	std::string get_address() const { return m_address; }

	/// \brief returns the port as specified in bind
	unsigned short get_port() const { return m_port; }

	/// \brief get_io_service has to be public since we need it to call notify_fork from child code
	boost::asio::io_service& get_io_service() { return m_io_service; }

  protected:

	/// \brief the default entry logger
	virtual void log_request(const std::string& client,
							 const request& req, const reply& rep,
							 const boost::posix_time::ptime& start,
							 const std::string& referer, const std::string& userAgent,
							 const std::string& entry) noexcept;

  private:
	friend class preforked_server_base;
	friend class connection;

	virtual void handle_request(boost::asio::ip::tcp::socket& socket,
								request& req, reply& rep);

	void handle_accept(boost::system::error_code ec);

	boost::asio::io_service m_io_service;
	std::shared_ptr<boost::asio::ip::tcp::acceptor> m_acceptor;
	std::list<std::thread> m_threads;
	std::shared_ptr<connection> m_new_connection;
	std::string m_address;
	unsigned short m_port;
	bool m_log_forwarded;
	bool m_add_csrf_token;
	std::unique_ptr<security_context> m_security_context;
	std::list<controller*> m_controllers;
	std::list<error_handler*> m_error_handlers;
};

} // namespace zeep::http
