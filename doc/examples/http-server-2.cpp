/* compile:
clang++  -o http-server-1 http-server-1.cpp -I ~/projects/boost_1_73_0 -DWEBAPP_USES_RESOURCES -I. -fPIC -pthread -std=c++17 -Wall -g -DDEBUG -I ../../include/ -L ../../lib -lzeep-http -lzeep-xml -lzeep-json dummy_rsrc.o  -lstdc++fs
*/

//[ simple_http_server
#undef WEBAPP_USES_RESOURCES
#define WEBAPP_USES_RESOURCES 0
#include <zeep/http/server.hpp>
#include <zeep/http/html-controller.hpp>

class hello_controller : public zeep::http::html_controller
{
  public:
    /*<< Specify the root path as prefix, will handle any request URI >>*/
    hello_controller() : zeep::http::html_controller("/", "docroot")
	{
		mount("{,index,index.html}", &hello_controller::handle_index);
	}

    void handle_index(const zeep::http::request& req, const zeep::http::scope& scope, zeep::http::reply& rep)
    {
        zeep::http::scope sub(scope);
		auto name = req.get_parameter("name");
		if (not name.empty())
			sub.put("name", name);
		create_reply_from_template("hello.xhtml", sub, rep);
    }
};

int main()
{
    zeep::http::server srv;

    srv.add_controller(new hello_controller());

    srv.bind("127.0.0.1", 8080);
    srv.run(2);

    return 0;
}
//]