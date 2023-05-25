#include <websocketpp/config/asio_no_tls.hpp>
#include <websocketpp/server.hpp>
#include <iostream>

typedef websocketpp::server<websocketpp::config::asio> server;

int main()
{
    try
    {
        server endpoint;

        // 設定回呼函式
        endpoint.set_message_handler([&endpoint](websocketpp::connection_hdl hdl, server::message_ptr msg) {
            std::cout << "Received message: " << msg->get_payload() << std::endl;
            endpoint.send(hdl, "Server received your message: " + msg->get_payload(), msg->get_opcode()); 
        });

        // 監聽 9002 連接埠
        endpoint.init_asio();
        endpoint.set_reuse_addr(true);
        endpoint.listen(9002);

        // 啟動伺服器
        endpoint.start_accept();

        // 開始處理連線請求
        endpoint.run();
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
    }

    return 0;
}
