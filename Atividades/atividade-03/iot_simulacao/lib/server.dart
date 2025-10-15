import 'dart:io';
import 'dart:convert';  // Para decodificar strings UTF-8

void main() async {
  const int port = 8080;
  const String host = '0.0.0.0';  // Escuta em todas as interfaces (use 'localhost' para testes locais)

  print('Iniciando servidor na porta $port...');

  try {
    final server = await ServerSocket.bind(host, port);
    print('Servidor escutando em $host:$port');

    await for (final socket in server) {
      print('Cliente conectado: ${socket.remoteAddress.address}:${socket.remotePort}');

      // Escuta dados assíncronos do socket
      socket.listen(
        (List<int> data) {
          try {
            final message = utf8.decode(data).trim();  // Decodifica e limpa a string
            if (message.isNotEmpty && message.startsWith('Temperatura:')) {
              print('Temperatura recebida: $message');
            }
          } catch (e) {
            print('Erro ao processar dados recebidos: $e');
          }
        },
        onError: (error) {
          print('Erro na conexão: $error');
          socket.destroy();  // Fecha o socket em caso de erro
        },
        onDone: () {
          print('Cliente desconectado.');
          socket.destroy();
        },
      );
    }
  } catch (e) {
    print('Erro ao iniciar servidor: $e');
    // Você pode adicionar lógica para reiniciar o servidor aqui
  }
}