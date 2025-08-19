import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();

  //@override
  //void didChangeDependencies() {
  //  super.didChangeDependencies();
  //  final args = ModalRoute.of(context)?.settings.arguments as Map?;
  //  if (args != null && args['userType'] != null) {
      // use args['userType'] instead of auth.userType
  //  }
  //}

}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  // Shared fields
  String name = "";
  String email = "";
  String phone = "";
  String address = "";

  // Client-specific
  String roomType = "";
  String budget = "";

  // Designer-specific
  String specialization = "";
  String experience = "";

  // Business-specific
  String companyName = "";
  String gstNumber = "";

  // Admin-specific
  String roleLevel = "";

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    //final userType = auth.userType; // Example: "client", "designer", "business", "admin"

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile & Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Delete Profile",
            onPressed: () {
              _confirmDelete();
            },
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            tooltip: isEditing ? "Save" : "Edit",
            onPressed: () {
              if (isEditing) {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  //_submitToBackend(userType);
                }
              }
              setState(() => isEditing = !isEditing);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Basic Information"),
              _buildTextField("Full Name", (v) => name = v!, initialValue: name),
              _buildTextField("Email", (v) => email = v!, initialValue: email, keyboardType: TextInputType.emailAddress),
              _buildTextField("Phone", (v) => phone = v!, initialValue: phone, keyboardType: TextInputType.phone),
              _buildTextField("Address", (v) => address = v!, initialValue: address),

              const SizedBox(height: 16),
              //if (userType == "client") _clientFields(),
              //if (userType == "designer") _designerFields(),
              //if (userType == "business") _businessFields(),
              //if (userType == "admin") _adminFields(),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save Changes"),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    //_submitToBackend(userType);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------
  // Dynamic Field Groups
  // --------------------
  Widget _clientFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Client Details"),
        _buildTextField("Room Type", (v) => roomType = v!, initialValue: roomType),
        _buildTextField("Budget", (v) => budget = v!, initialValue: budget, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _designerFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Designer Details"),
        _buildTextField("Specialization", (v) => specialization = v!, initialValue: specialization),
        _buildTextField("Experience (years)", (v) => experience = v!, initialValue: experience, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _businessFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Business Details"),
        _buildTextField("Company Name", (v) => companyName = v!, initialValue: companyName),
        _buildTextField("GST Number", (v) => gstNumber = v!, initialValue: gstNumber),
      ],
    );
  }

  Widget _adminFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Admin Details"),
        _buildTextField("Role Level", (v) => roleLevel = v!, initialValue: roleLevel),
      ],
    );
  }

  // --------------------
  // Helper Widgets
  // --------------------
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(
      String label,
      FormFieldSetter<String> onSaved, {
        String? initialValue,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextFormField(
      enabled: isEditing,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      initialValue: initialValue,
      validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }

  // --------------------
  // Actions
  // --------------------
  void _submitToBackend(String userType) {
    // later we replace this with real backend API
    debugPrint("Submitting profile for $userType:");
    debugPrint("Name: $name, Email: $email, Phone: $phone, Address: $address");

    if (userType == "client") {
      debugPrint("RoomType: $roomType, Budget: $budget");
    } else if (userType == "designer") {
      debugPrint("Specialization: $specialization, Experience: $experience");
    } else if (userType == "business") {
      debugPrint("CompanyName: $companyName, GST: $gstNumber");
    } else if (userType == "admin") {
      debugPrint("Role Level: $roleLevel");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile saved (mock backend).")),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Profile"),
        content: const Text("Are you sure you want to delete your profile? This action cannot be undone."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _deleteProfile();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _deleteProfile() {
    // later this will call backend
    debugPrint("Profile deleted.");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile deleted (mock backend).")),
    );
  }
}
