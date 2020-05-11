// Copyright Maarten L. Hekkelman, Radboud University 2008-2013.
//        Copyright Maarten L. Hekkelman, 2014-2019
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

#pragma once

#include <string>

namespace zeep::http
{

/// The header object contains the header lines as found in a
/// HTTP Request. The lines are parsed into name / value pairs.

struct header
{
	std::string	name;
	std::string	value;
};
	
}
