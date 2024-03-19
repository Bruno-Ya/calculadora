import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculadora());
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String mensagemVisor = '';

  // - 3: Para resolver as equações com as operações disponíveis em nossa calculadora utilizaremos um pacote chamado math_expressions. Esse paco consegue pegar uma equação elaborada, como por exemplo (3+2) ou (10+5)/3 e resolvê-la. Nesse sentido, crie um método chamado setarValor que receberá um parâmetro do tipo String para o valor da tecla pressionada.
  // - 5: Dentro do método setValor insira um setState e dentro do setState crie uma estrutura condicional que deve testar se a variável mensagemVisor é igual a 0. Caso seja, a variável mensagemVisor deve apenas receber o primeiro valor repassado, caso contrário, utilize o += para receber e concatenar o valor na String e formar a expressão.
  void setarValor(String valor) {
    setState(() {
      if (mensagemVisor == '0') {
        mensagemVisor = valor;
      } else {
        mensagemVisor += valor;
      }
    });
  }

  // - 6: Crie um método chamado resetar para zerar a calculadora caso precise realizar outras contas.
  void apagar() {
    setState(() {
      if (mensagemVisor.isNotEmpty) {
        mensagemVisor = mensagemVisor.substring(0, mensagemVisor.length - 1);
      }
    });
  }

  void resetar() {
    setState(() {
      mensagemVisor = '0';
    });
  }

  // - 10: Crie um método chamado realizarCalculo.
void realizarCalculo() {
  Parser p = Parser();
  Expression expressao = p.parse(mensagemVisor);
  ContextModel cm = ContextModel();

  // Verifica se a expressão contém o operador %
  if (mensagemVisor.contains('%')) {
    // Divide a expressão em partes, separadas pelo operador %
    List<String> partes = mensagemVisor.split('%');
    double valor = double.parse(partes[0]); // Valor à esquerda do %
    double porcentagem = double.parse(partes[1]); // Porcentagem à direita do %

    // Calcula a porcentagem
    double resultado = valor * (porcentagem / 100);

    // Atualiza a mensagemVisor com o resultado da porcentagem
    setState(() {
      mensagemVisor = resultado.toString();
    });
  } else {
    // Avalia a expressão normalmente
    double resolucaoDaExpressao = expressao.evaluate(EvaluationType.REAL, cm);
    setState(() {
      mensagemVisor = resolucaoDaExpressao.toString();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text(
            'Calculadora',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                margin: const EdgeInsets.all(15),
                width: 400.0,
                height: 120.0,
                child: Center(
                  child: Text(
                    mensagemVisor,
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    constroiBotoesCalculadora(
                        caracterDaTecla: 'C',
                        onPress: () {
                          setState(() {
                            apagar();
                          });
                        }),
                    constroiBotoesCalculadora(
                      caracterDaTecla: 'DEL',
                      onPress: () {
                        setState(() {
                          resetar();
                        });
                      },
                    ),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '%', onPress: () => {setarValor('%')}),
                    constroiBotoesCalculadora(
                      caracterDaTecla: '/',
                      onPress: () => {setarValor('/')},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    constroiBotoesCalculadora(
                      caracterDaTecla: '7',
                      onPress: () => {setarValor('7')},
                    ),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '8', onPress: () => {setarValor('8')}),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '9', onPress: () => {setarValor('9')}),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '*', onPress: () => {setarValor('*')}),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    constroiBotoesCalculadora(
                        caracterDaTecla: '4', onPress: () => {setarValor('4')}),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '5', onPress: () => {setarValor('5')}),
                    constroiBotoesCalculadora(
                      caracterDaTecla: '6',
                      onPress: () => {
                        {setarValor('6')},
                      },
                    ),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '+', onPress: () => {setarValor('+')}),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    constroiBotoesCalculadora(
                        caracterDaTecla: '1', onPress: () => {setarValor('1')}),
                    constroiBotoesCalculadora(
                      caracterDaTecla: '2',
                      onPress: () => {setarValor('2')},
                    ),
                    constroiBotoesCalculadora(
                      caracterDaTecla: '3',
                      onPress: () => {setarValor('3')},
                    ),
                    constroiBotoesCalculadora(
                      caracterDaTecla: '-',
                      onPress: () => {setarValor('-')},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    constroiBotoesCalculadora(
                      caracterDaTecla: '0',
                      onPress: () => {setarValor('0')},
                    ),
                    constroiBotoesCalculadora(
                      caracterDaTecla: '.',
                      onPress: () => {setarValor('.')},
                    ),
                    constroiBotoesCalculadora(
                        caracterDaTecla: '=',
                        onPress: () => {realizarCalculo()}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // - 1 : Crie uma função que será responsável por construir os botões da calculadora evitando a redundância que temos atualmente no código-fonte. Se tiver dúvidas quanto à criação dessa função volte e assista a aula #41 - App Marimba - Atualizando a interface do nosso App (https://www.youtube.com/watch?v=HevYf8Pila4).
  Expanded constroiBotoesCalculadora(
      {required String caracterDaTecla, required Function onPress}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          padding: const EdgeInsets.all(
            20.0,
          ),
        ),
        child: Text(
          caracterDaTecla,
          style: const TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }
}