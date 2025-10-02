import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() {
    return {"nome": _nome};
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": _nome,
      "dependentes": _dependentes.map((d) => d.toJson()).toList()
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeProjeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeProjeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      "nomeProjeto": _nomeProjeto,
      "funcionarios": _funcionarios.map((f) => f.toJson()).toList()
    };
  }
}

void main() {
  // 1. Criar vários objetos Dependentes
  Dependente lorran = Dependente("Lorran");
  Dependente lord = Dependente("Lord");
  Dependente pedro = Dependente("Pedro");
  Dependente pedrokekw = Dependente("Pedrokekw");

  // 2. Criar objetos Funcionario e associar dependentes
  Funcionario lorn = Funcionario("Lorn", [lorran, lord]);
  Funcionario herdeiro = Funcionario("Herdeiro", [pedro, pedrokekw]);

  // 3. Criar lista de Funcionarios
  var voluntarios = [lorn, herdeiro];

  // 4. Criar objeto EquipeProjeto
  EquipeProjeto spermBovine = EquipeProjeto("SpermBovine", voluntarios);

  // 5. Printar no formato JSON
  String json = jsonEncode(spermBovine.toJson());
  print(json);
}
