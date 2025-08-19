import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_routes.dart';
import '../../core/constants.dart';
import '../../services/auth_service.dart';
import '../../widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _role = AppConst.roleClient;
  bool _loading = false;
  bool _obscure = true;
  bool _agree = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  int get _strength => context.read<AuthService>().passwordStrength(_password.text);

  Future<void> _doRegister() async {
    if (!_form.currentState!.validate()) return;
    if (!_agree) {
      _showError('You must accept Terms & Privacy');
      return;
    }
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().register(
        name: _name.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
        role: _role,
      );
      switch (_role) {
        case AppConst.roleBusiness:
          Navigator.pushReplacementNamed(context, AppRoutes.businessHome);
          break;
        case AppConst.roleDesigner:
          Navigator.pushReplacementNamed(context, AppRoutes.designerHome);
          break;
        default:
          Navigator.pushReplacementNamed(context, AppRoutes.clientHome);
      }
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg.replaceFirst('Exception: ', '')),
      backgroundColor: Colors.red.shade700,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 520;

    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Enter name';
                        if (!AppConst.nameRegex.hasMatch(v.trim())) return 'Enter a valid name';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Enter email';
                        if (!AppConst.emailRegex.hasMatch(v.trim())) return 'Invalid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                        ),
                        helperText: _strength <= 2
                            ? 'Use upper, lower, number & symbol for a stronger password'
                            : 'Strong password',
                      ),
                      validator: (v) =>
                      (v == null || v.length < AppConst.minPasswordLen)
                          ? 'Min ${AppConst.minPasswordLen} chars'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    _PasswordMeter(value: _strength / 4.0),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _role,
                      items: const [
                        DropdownMenuItem(value: AppConst.roleClient, child: Text('Client')),
                        DropdownMenuItem(value: AppConst.roleDesigner, child: Text('Interior Designer')),
                        DropdownMenuItem(value: AppConst.roleBusiness, child: Text('Business User')),
                      ],
                      onChanged: (v) => setState(() => _role = v!),
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        prefixIcon: Icon(Icons.account_circle_outlined),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'Select role' : null,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v ?? false)),
                        Flexible(
                          child: Wrap(
                            children: [
                              const Text('I agree to the '),
                              InkWell(onTap: () {}, child: const Text('Terms')),
                              const Text(' & '),
                              InkWell(onTap: () {}, child: const Text('Privacy Policy')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    PrimaryButton(
                      label: 'Create account',
                      icon: Icons.person_add_alt_1,
                      onPressed: _doRegister,
                      loading: _loading,
                    ),
                    if (!compact) const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordMeter extends StatelessWidget {
  final double value;
  const _PasswordMeter({required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value.clamp(0.0, 1.0),
      minHeight: 6,
      borderRadius: BorderRadius.circular(8),
    );
  }
}

