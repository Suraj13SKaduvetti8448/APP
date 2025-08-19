import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_routes.dart';
import '../../core/constants.dart';
import '../../services/auth_service.dart';
import '../../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _role = AppConst.roleClient;
  bool _loading = false;
  bool _obscure = true;
  bool _remember = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().login(
        email: _email.text.trim(),
        password: _password.text,
        role: _role,
      );
      _redirectByRole();
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _redirectByRole() {
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
    final narrow = width < AppConst.gridBreakpoint;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!narrow)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _PromoPanel(),
                  ),
                ),
              Expanded(
                child: Card(
                  elevation: 1,
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Welcome to FurniTracker',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          Text('Sign in to continue', style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 18),
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
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obscure = !_obscure),
                                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            validator: (v) =>
                            (v == null || v.length < AppConst.minPasswordLen)
                                ? 'Min ${AppConst.minPasswordLen} chars'
                                : null,
                          ),
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
                              Checkbox(
                                value: _remember,
                                onChanged: (v) => setState(() => _remember = v ?? true),
                              ),
                              const Text('Remember me'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Forgot password?'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          PrimaryButton(
                            label: 'Login',
                            icon: Icons.login_rounded,
                            onPressed: _doLogin,
                            loading: _loading,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don’t have an account?"),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                                child: const Text('Create one'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(AppConst.mockProduct, height: 280, fit: BoxFit.cover),
        ),
        const SizedBox(height: 16),
        const ListTile(
          leading: Icon(Icons.verified),
          title: Text('Plan. Suggest. Approve.'),
          subtitle: Text('Smooth collaboration between Clients, Designers, and Businesses.'),
        ),
        const ListTile(
          leading: Icon(Icons.flash_on),
          title: Text('Fast & Responsive'),
          subtitle: Text('Works great on web and Android—iOS next.'),
        ),
      ],
    );
  }
}

