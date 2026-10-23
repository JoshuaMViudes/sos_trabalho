class Validators {
  static String? required(String? value, {String field = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field é obrigatório';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email é obrigatório';
    final regex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Senha é obrigatória';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  static String? cpf(String? value) {
    if (value == null || value.isEmpty) return 'CPF é obrigatório';
    final nums = value.replaceAll(RegExp(r'\D'), '');
    if (nums.length != 11) return 'CPF incompleto';
    return null;
  }

  static String? cnpj(String? value) {
    if (value == null || value.isEmpty) return 'CNPJ é obrigatório';
    final nums = value.replaceAll(RegExp(r'\D'), '');
    if (nums.length != 14) return 'CNPJ incompleto';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Telefone é obrigatório';
    final nums = value.replaceAll(RegExp(r'\D'), '');
    if (nums.length < 10) return 'Telefone incompleto';
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nome é obrigatório';
    if (!value.trim().contains(' ')) return 'Digite seu nome completo';
    return null;
  }
}
