#ifndef XML_SOAP_DISPATCHER_H
#define XML_SOAP_DISPATCHER_H

#include <boost/static_assert.hpp>
#include "xml/soap/handler.hpp"

#include <typeinfo>

namespace xml
{
namespace soap
{

template<class C, typename F>
struct call_traits_base;

template<class C, typename T1, typename T2, typename R>
struct call_traits_base<C, void (C::*)(const T1&, const T2&, R&)>
{
	typedef call<C,void(const T1&, const T2&, R&)> type;
};


template<class Derived>
class dispatcher : public boost::noncopyable
{
  public:
					dispatcher() {}

	void			dispatch(
						const char*		action,
						xml::node_ptr	in,
						xml::node_ptr	out);

	template<typename F>
	void			register_soap_call(
						const char*		action,
						typename call<Derived,F>::call_func_type				call_,
						const char*		arg1)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 1);
						
						const char* names[1] = { arg1 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 2);
						
						const char* names[2] = { arg1, arg2 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 3);
						
						const char* names[3] = { arg1, arg2, arg3 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3,
						const char*		arg4)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 4);
						
						const char* names[4] = { arg1, arg2, arg3, arg4 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3,
						const char*		arg4,
						const char*		arg5)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 5);
						
						const char* names[5] = { arg1, arg2, arg3, arg4, arg5 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3,
						const char*		arg4,
						const char*		arg5,
						const char*		arg6)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 6);
						
						const char* names[6] = { arg1, arg2, arg3, arg4, arg5, arg6 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3,
						const char*		arg4,
						const char*		arg5,
						const char*		arg6,
						const char*		arg7)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 7);
						
						const char* names[7] = { arg1, arg2, arg3, arg4, arg5, arg6, arg7 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3,
						const char*		arg4,
						const char*		arg5,
						const char*		arg6,
						const char*		arg7,
						const char*		arg8)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 8);
						
						const char* names[8] = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

	template<typename F>
	void			register_soap_call(
						const char*		action,
						F				call_,
						const char*		arg1,
						const char*		arg2,
						const char*		arg3,
						const char*		arg4,
						const char*		arg5,
						const char*		arg6,
						const char*		arg7,
						const char*		arg8,
						const char*		arg9)
					{
						enum { required_count = call<Derived,F>::name_count };
						BOOST_STATIC_ASSERT(required_count == 9);
						
						const char* names[9] = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 };
						
						actions.push_back(
							new call<Derived,F>(action, static_cast<Derived*>(this), call_, names));
					}

  private:
	
	boost::ptr_vector<handler_base>
					actions;
};

template<class Derived>
void dispatcher<Derived>::dispatch(
	const char*		action,
	xml::node_ptr	in,
	xml::node_ptr	out)
{
	boost::ptr_vector<handler_base>::iterator cb = find_if(actions.begin(), actions.end(),
		boost::bind(&handler_base::get_action_name, _1) == action);

	if (cb == actions.end())
		throw xml::exception("Action not specified");
	
	cb->call(in, out);
}

}
}

#endif
