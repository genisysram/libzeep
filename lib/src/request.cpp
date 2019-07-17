// Copyright Maarten L. Hekkelman, Radboud University 2008-2013.
//        Copyright Maarten L. Hekkelman, 2014-2019
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

#include <zeep/config.hpp>

#include <cassert>
#include <sstream>

#include <zeep/http/request.hpp>
#include <zeep/http/server.hpp>

#include <boost/algorithm/string.hpp>

namespace ba = boost::algorithm;

namespace zeep { namespace http {

using xml::iequals;

void request::clear()
{
	m_request_line.clear();
	m_timestamp = boost::posix_time::second_clock::local_time();

	method = method_type::UNDEFINED;
	uri.clear();
	http_version_major = 1;
	http_version_minor = 0;
	headers.clear();
	payload.clear();
	close = true;
	local_address.clear();
	local_port = 0;
}

float request::accept(const char* type) const
{
	float result = 1.0f;

#define IDENT		"[-+.a-z0-9]+"
#define TYPE		"\\*|" IDENT
#define MEDIARANGE	"\\s*(" TYPE ")/(" TYPE ").*?(?:;\\s*q=(\\d(?:\\.\\d?)?))?"

	static boost::regex rx(MEDIARANGE);

	assert(type);
	if (type == nullptr)
		return 1.0;

	std::string t1(type), t2;
	std::string::size_type s = t1.find('/');
	if (s != std::string::npos)
	{
		t2 = t1.substr(s + 1);
		t1.erase(s, t1.length() - s);
	}
	
	for (const header& h: headers)
	{
		if (h.name != "Accept")
			continue;
		
		result = 0;

		std::string::size_type b = 0, e = h.value.find(',');
		for (;;)
		{
			if (e == std::string::npos)
				e = h.value.length();
			
			std::string mediarange = h.value.substr(b, e - b);
			
			boost::smatch m;
			if (boost::regex_search(mediarange, m, rx))
			{
				std::string type1 = m[1].str();
				std::string type2 = m[2].str();

				float value = 1.0f;
				if (m[3].matched)
					value = boost::lexical_cast<float>(m[3].str());
				
				if (type1 == t1 and type2 == t2)
				{
					result = value;
					break;
				}
				
				if ((type1 == t1 and type2 == "*") or
					(type1 == "*" and type2 == "*"))
				{
					if (result < value)
						result = value;
				}
			}
			
			if (e == h.value.length())
				break;

			b = e + 1;
			while (b < h.value.length() and isspace(h.value[b]))
				++b;
			e = h.value.find(',', b);
		}

		break;
	}
	
	return result;
}

const boost::regex
	b("(bb\\d+|meego).+mobile|android|avantgo|bada\\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",
		boost::regex::icase),
	v("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\\-|your|zeto|zte\\-",
		boost::regex::icase);

bool request::is_mobile() const
{
	// this code is adapted from code generated by http://detectmobilebrowsers.com/
	bool result = false;
	
	for (const header& h: headers)
	{
		if (h.name != "User-Agent")
			continue;
		
		result = boost::regex_search(h.value, b) or boost::regex_match(h.value.substr(0, 4), v);
		break;
    }
    
    return result;
}

bool request::keep_alive() const
{
	bool result = false;

	for (const header& h: headers)
	{
		if (h.name != "Connection")
			continue;

		result = iequals(h.value, "keep-alive");
		break;
	}

	return result;
}

std::string request::get_header(const char* name) const
{
	std::string result;

	for (const header& h: headers)
	{
		if (not iequals(h.name, name))
			continue;
		
		result = h.value;
		break;
    }

	return result;
}

void request::remove_header(const char* name)
{
	headers.erase(
		remove_if(headers.begin(), headers.end(),
			[name](const header& h) -> bool { return h.name == name; }),
		headers.end());
}

std::pair<std::string,bool> get_urlencode_parameter(const std::string& s, const char* name)
{
	std::string::size_type b = 0;
	std::string result;
	bool found = false;
	size_t nlen = strlen(name);
	
	while (b != std::string::npos)
	{
		std::string::size_type e = s.find_first_of("&;", b);
		std::string::size_type n = (e == std::string::npos) ? s.length() - b : e - b;
		
		if ((n == nlen or (n > nlen + 1 and s[b + nlen] == '=')) and strncmp(name, s.c_str() + b, nlen) == 0)
		{
			found = true;

			if (n == nlen)
				result = name;	// what else?
			else
			{
				b += nlen + 1;
				result = s.substr(b, e - b);
				result = decode_url(result);
			}
			
			break;
		}
		
		b = e == std::string::npos ? e : e + 1;
	}

	return std::make_pair(result, found);
}

std::tuple<std::string,bool> request::get_parameter_ex(const char* name) const
{
	std::string result, contentType = get_header("Content-Type");
	bool found = false;

	// shortcuts
	auto pp = std::find_if(path_params.begin(), path_params.end(), [name](auto& p) { return p.name == name; });
	if (pp != path_params.end())
		return std::make_tuple(pp->value, true);
	
	if (contentType == "application/x-www-form-urlencoded")
	{
		tie(result, found) = get_urlencode_parameter(payload, name);
		if (found)
			return std::make_tuple(result, true);
	}

	auto b = uri.find('?');
	if (b != std::string::npos)
	{
		tie(result, found) = get_urlencode_parameter(uri.substr(b + 1), name);
		if (found)
			return std::make_tuple(result, true);
	}

	if (ba::starts_with(contentType, "multipart/form-data"))
	{
		std::string::size_type b = contentType.find("boundary=");
		if (b != std::string::npos)
		{
			std::string boundary = contentType.substr(b + strlen("boundary="));
			
			enum { START, HEADER, CONTENT, SKIP } state = SKIP;
			
			std::string contentName;
			boost::regex rx("content-disposition:\\s*form-data;.*?\\bname=\"([^\"]+)\".*", boost::regex::icase);
			boost::smatch m;
			
			std::string::size_type i = 0, r = 0, l = 0;
			
			for (i = 0; i <= payload.length(); ++i)
			{
				if (i < payload.length() and payload[i] != '\r' and payload[i] != '\n')
					continue;

				// we have found a 'line' at [l, i)
				if (payload.compare(l, 2, "--") == 0 and
					payload.compare(l + 2, boundary.length(), boundary) == 0)
				{
					// if we're in the content state or if this is the last line
					if (state == CONTENT or payload.compare(l + 2 + boundary.length(), 2, "--") == 0)
					{
						if (r > 0)
						{
							auto n = l - r;
							if (n >= 1 and payload[r + n - 1] == '\n')
								--n;
							if (n >= 1 and payload[r + n - 1] == '\r')
								--n;

							result.assign(payload, r, n);
						}
							
						break;
					}
					
					// Not the last, so it must be a separator and we're now in the Header part
					state = HEADER;
				}
				else if (state == HEADER)
				{
					if (l == i)	// empty line
					{
						if (contentName == name)
						{
							found = true;
							state = CONTENT;

							r = i + 1;
							if (payload[i] == '\r' and payload[i + 1] == '\n')
								r = i + 2;
						}
						else
							state = SKIP;
					}
					else if (boost::regex_match(payload.begin() + l, payload.begin() + i, m, rx))
						contentName = m[1].str();
				}
				
				if (payload[i] == '\r' and payload[i + 1] == '\n')
					++i;

				l = i + 1;
			}
		}

		ba::replace_all(result, "\r\n", "\n");
	}
	
	return make_tuple(result, found);
}

std::string request::get_cookie(const char* name) const
{
	for (const header& h : headers)
	{
		if (h.name != "Cookie")
			continue;

		std::vector<std::string> rawCookies;
		ba::split(rawCookies, h.value, ba::is_any_of(";"));

		for (std::string& cookie : rawCookies)
		{
			ba::trim(cookie);

			auto d = cookie.find('=');
			if (d == std::string::npos)
				continue;
			
			if (cookie.compare(0, d, name) == 0)
				return cookie.substr(d + 1);
		}
	}

	return "";
}

std::string request::get_request_line() const
{
	return to_string(method) + std::string{' '} + uri + " HTTP/" + std::to_string(http_version_major) + '.' + std::to_string(http_version_minor);
}

namespace
{
const char
		kNameValueSeparator[] = { ':', ' ' },
		kCRLF[] = { '\r', '\n' };
}

void request::to_buffers(std::vector<boost::asio::const_buffer>& buffers)
{
	m_request_line = get_request_line();
	buffers.push_back(boost::asio::buffer(m_request_line));
	buffers.push_back(boost::asio::buffer(kCRLF));
	
	for (header& h: headers)
	{
		buffers.push_back(boost::asio::buffer(h.name));
		buffers.push_back(boost::asio::buffer(kNameValueSeparator));
		buffers.push_back(boost::asio::buffer(h.value));
		buffers.push_back(boost::asio::buffer(kCRLF));
	}

	buffers.push_back(boost::asio::buffer(kCRLF));
	buffers.push_back(boost::asio::buffer(payload));
}

std::iostream& operator<<(std::iostream& io, request& req)
{
	std::vector<boost::asio::const_buffer> buffers;

	req.to_buffers(buffers);

	for (auto& b: buffers)
		io.write(boost::asio::buffer_cast<const char*>(b), boost::asio::buffer_size(b));

	return io;
}

void request::debug(std::ostream& os) const
{
	os << get_request_line() << std::endl;
	for (const header& h: headers)
		os << h.name << ": " << h.value << std::endl;
}

} // http
} // zeep