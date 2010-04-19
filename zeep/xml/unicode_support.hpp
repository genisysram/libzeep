//  Copyright Maarten L. Hekkelman, Radboud University 2010.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

#ifndef ZEEP_XML_UNICODE_SUPPORT_HPP
#define ZEEP_XML_UNICODE_SUPPORT_HPP

#include <string>

namespace zeep { namespace xml {

// the supported encodings. Perhaps we should extend this list a bit?
enum encoding_type
{
	enc_UTF8,
	enc_UTF16BE,
	enc_UTF16LE,
//	enc_ISO88591
};

// some character classification routines
bool is_name_start_char(wchar_t uc);
bool is_name_char(wchar_t uc);
bool is_char(wchar_t uc);
bool is_valid_system_literal_char(wchar_t uc);
bool is_valid_system_literal(const std::string& s);
bool is_valid_public_id_char(wchar_t uc);
bool is_valid_public_id(const std::string& s);

// Convert a string from UCS4 to UTF-8
std::string wstring_to_string(const std::wstring& s);

void append(std::string& s, wchar_t ch);
wchar_t pop_last_char(std::string& s);

// inlines

inline bool is_char(wchar_t uc)
{
	return
		uc == 0x09 or
		uc == 0x0A or
		uc == 0x0D or
		(uc >= 0x020 and uc <= 0x0D7FF) or
		(uc >= 0x0E000 and uc <= 0x0FFFD) or
		(uc >= 0x010000 and uc <= 0x010FFFF);
}

inline void append(std::string& s, wchar_t ch)
{
	unsigned long cv = static_cast<unsigned long>(ch);
	
	if (cv < 0x080)
		s += (static_cast<const char> (cv));
	else if (cv < 0x0800)
	{
		s += (static_cast<const char> (0x0c0 | (cv >> 6)));
		s += (static_cast<const char> (0x080 | (cv & 0x3f)));
	}
	else if (cv < 0x00010000)
	{
		s += (static_cast<const char> (0x0e0 | (cv >> 12)));
		s += (static_cast<const char> (0x080 | ((cv >> 6) & 0x3f)));
		s += (static_cast<const char> (0x080 | (cv & 0x3f)));
	}
	else
	{
		s += (static_cast<const char> (0x0f0 | (cv >> 18)));
		s += (static_cast<const char> (0x080 | ((cv >> 12) & 0x3f)));
		s += (static_cast<const char> (0x080 | ((cv >> 6) & 0x3f)));
		s += (static_cast<const char> (0x080 | (cv & 0x3f)));
	}
}

inline wchar_t pop_last_char(std::string& s)
{
	assert(not s.empty());
	
	wchar_t result = 0;

	if (not s.empty())
	{
		std::string::iterator ch = s.end() - 1;
		
		if ((*ch & 0x0080) == 0)
		{
			result = *ch;
			s.erase(ch);
		}
		else
		{
			int o = 0;
			
			do
			{
				result |= (*ch & 0x03F) << o;
				o += 6;
				--ch;
			}
			while (ch != s.begin() and (*ch & 0x0C0) == 0x080);
			
			switch (o)
			{
				case  6: result |= (*ch & 0x01F) <<  6; break;
				case 12: result |= (*ch & 0x00F) << 12; break;
				case 18: result |= (*ch & 0x007) << 18; break;
			}
			
			s.erase(ch, s.end());
		}
	}
	
	return result;
}


}
}

#endif
