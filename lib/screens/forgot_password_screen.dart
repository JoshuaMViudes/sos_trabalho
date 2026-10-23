import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import '../utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _step = 0; // 0 = email | 1 = código | 2 = nova senha
  bool _loading = false;

  final _emailCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _codeCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _loading = false);

    if (_step == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código enviado para ${_emailCtrl.text}')),
      );
      setState(() => _step = 1);
    } else if (_step == 1) {
      setState(() => _step = 2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senha redefinida com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.popUntil(context, (r) => r.isFirst);
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  String _title() {
    switch (_step) {
      case 0:
        return 'Recuperar Senha';
      case 1:
        return 'Verificação';
      default:
        return 'Nova Senha';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title())),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: _buildStep(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStep() {
    if (_step == 0) {
      return [
        const Icon(
          Icons.mark_email_unread_outlined,
          size: 64,
          color: AppColors.primary,
        ),
        const SizedBox(height: 24),
        const Text(
          'Esqueceu sua senha?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Digite seu email cadastrado. Enviaremos um código de 6 dígitos.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _emailCtrl,
          validator: Validators.email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Seu email',
            prefixIcon: const Icon(Icons.email_outlined),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _button('Enviar Código'),
      ];
    }

    if (_step == 1) {
      return [
        const Icon(Icons.security, size: 64, color: AppColors.brand),
        const SizedBox(height: 24),
        const Text(
          'Digite o código',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enviamos um código para\n${_emailCtrl.text}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _codeCtrl,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontSize: 24,
            letterSpacing: 8,
            fontWeight: FontWeight.w700,
          ),
          validator: (v) {
            if (v == null || v.length != 6) return 'Digite os 6 dígitos';
            return null;
          },
          decoration: InputDecoration(
            hintText: '000000',
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _button('Verificar Código'),
        TextButton(
          onPressed: () {},
          child: const Text('Não recebi. Reenviar código'),
        ),
      ];
    }

    return [
      const Icon(Icons.lock_reset, size: 64, color: AppColors.primary),
      const SizedBox(height: 24),
      const Text(
        'Crie uma nova senha',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.navy,
        ),
      ),
      const SizedBox(height: 24),
      TextFormField(
        controller: _newPassCtrl,
        obscureText: true,
        validator: Validators.password,
        decoration: InputDecoration(
          hintText: 'Nova senha',
          prefixIcon: const Icon(Icons.lock_outline),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _confirmPassCtrl,
        obscureText: true,
        validator: (v) {
          if (v != _newPassCtrl.text) return 'As senhas não coincidem';
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Confirmar senha',
          prefixIcon: const Icon(Icons.lock_outline),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 24),
      _button('Redefinir Senha'),
    ];
  }

  Widget _button(String label) {
    return SizedBox(
      height: 50,
      child: FilledButton(
        onPressed: _loading ? null : _next,
        child: _loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
