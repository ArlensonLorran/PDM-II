import 'dart:io';
import 'dart:async';
import 'dart:math';  // Para gerar números aleatórios

void main() async {
  const String host = 'localhost';  // Altere para o IP do servidor se necessário
  const int port = 8080;
  const Duration interval = Duration(seconds: 10);  // Intervalo de envio

  print('Iniciando simulação de dispositivo IoT...');

  while (true) {  // Loop infinito para reconexão em caso de erro
    try {
      final socket = await Socket.connect(host, port);
      print('Conectado ao servidor em $host:$port');

      final random = Random();
      final timer = Timer.periodic(interval, (Timer t) async {
        final double temperature = 20.0 + random.nextDouble() * 10.0;  // Temperatura aleatória entre 20.0 e 30.0°C
        final String message = 'Temperatura: ${temperature.toStringAsFixed(1)}°C\n';
        
        socket.write(message);  // Envia a mensagem
        await socket.flush();  // Garante que os dados sejam enviados imediatamente
        print('Enviando: $message');
      });

      // Mantém a conexão aberta indefinidamente (até erro ou interrupção)
      await socket.done;  // Aguarda o socket ser fechado
      timer.cancel();
      print('Conexão fechada pelo servidor.');
    } catch (e) {
      print('Erro na conexão: $e. Tentando reconectar em 5 segundos...');
      await Future.delayed(Duration(seconds: 5));  // Aguarda antes de tentar reconectar
    }
  }
}