import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';

// 🛠️ Máscara Nativa (Sem precisar de pacotes externos)
class CustomMaskFormatter extends TextInputFormatter {
  final String mask;
  final String filter;

  CustomMaskFormatter({required this.mask, this.filter = '#'});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    if (newValue.text.length < oldValue.text.length) return newValue;

    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final chars = digitsOnly.split('');
    var result = '';
    var charIndex = 0;

    for (var i = 0; i < mask.length; i++) {
      if (charIndex >= chars.length) break;
      if (mask[i] == filter) {
        result += chars[charIndex];
        charIndex++;
      } else {
        result += mask[i];
      }
    }

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'Trabalhador';
  bool _loading = false;
  bool _obscurePassword = true;

  final _nameCtrl = TextEditingController();
  final _docCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // Instâncias das máscaras nativas
  final _cpfMask = CustomMaskFormatter(mask: '###.###.###-##');
  final _cnpjMask = CustomMaskFormatter(mask: '##.###.###/####-##');
  final _phoneMask = CustomMaskFormatter(mask: '(##) #####-####');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _docCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // --- VALIDADORES ---
  String? _valEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email é obrigatório';
    if (!RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.trim())) {
      return 'Email inválido';
    }
    return null;
  }

  String? _valPass(String? v) {
    if (v == null || v.isEmpty) return 'Senha é obrigatória';
    if (v.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  String? _valCPF(String? v) {
    if (v == null || v.isEmpty) return 'CPF é obrigatório';
    if (v.replaceAll(RegExp(r'\D'), '').length != 11) return 'CPF incompleto';
    return null;
  }

  String? _valCNPJ(String? v) {
    if (v == null || v.isEmpty) return 'CNPJ é obrigatório';
    if (v.replaceAll(RegExp(r'\D'), '').length != 14) return 'CNPJ incompleto';
    return null;
  }

  String? _valPhone(String? v) {
    if (v == null || v.isEmpty) return 'Telefone é obrigatório';
    if (v.replaceAll(RegExp(r'\D'), '').length < 10)
      return 'Telefone incompleto';
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifique os campos com erro em vermelho'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    final isTrabalhador = _type == 'Trabalhador';

    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Quero me cadastrar como:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _typeCard('Trabalhador', Icons.engineering),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _typeCard('Contratante', Icons.business_center),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Nome ou Razão Social
                TextFormField(
                  controller: _nameCtrl,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (isTrabalhador
                            ? 'Nome é obrigatório'
                            : 'Razão Social é obrigatória')
                      : null,
                  decoration: InputDecoration(
                    hintText: isTrabalhador
                        ? 'Nome completo'
                        : 'Razão Social da Empresa',
                    prefixIcon: Icon(
                      isTrabalhador ? Icons.person_outline : Icons.business,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // CPF ou CNPJ com Máscara
                TextFormField(
                  controller: _docCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    isTrabalhador ? _cpfMask : _cnpjMask,
                  ],
                  validator: isTrabalhador ? _valCPF : _valCNPJ,
                  decoration: InputDecoration(
                    hintText: isTrabalhador
                        ? 'CPF (000.000.000-00)'
                        : 'CNPJ (00.000.000/0000-00)',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: _valEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Telefone com Máscara
                TextFormField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _phoneMask,
                  ],
                  validator: _valPhone,
                  decoration: InputDecoration(
                    hintText: 'Telefone / WhatsApp',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Senha
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscurePassword,
                  validator: _valPass,
                  decoration: InputDecoration(
                    hintText: 'Criar Senha (mín. 6 caracteres)',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botão com Loading
                SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Cadastrar e Entrar',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Já tenho conta • Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeCard(String name, IconData icon) {
    final sel = _type == name;
    return InkWell(
      onTap: () => setState(() {
        _type = name;
        _docCtrl.clear();
      }),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: sel ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: sel ? AppColors.primary : AppColors.hairline,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: sel ? Colors.white : AppColors.primary, size: 28),
            const SizedBox(height: 6),
            Text(
              name,
              style: TextStyle(
                color: sel ? Colors.white : AppColors.navy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
