import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedGender = 'Male';
  DateTime? _selectedDate;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _whatsappNumberController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _collegeNameController = TextEditingController();
  final TextEditingController _collegeStateController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _degreeNameController = TextEditingController();
  final TextEditingController _passingYearController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register to get started',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildPersonalInformationSection(),
                SizedBox(height: 20),
                _buildContactInformationSection(),
                SizedBox(height: 20),
                _buildEducationalInformationSection(),
                SizedBox(height: 20),
                _buildPasswordSection(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInformationSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10),
          _buildTextField('Full Name', _fullNameController),
          _buildTextField('Father\'s Full Name', _fatherNameController),
          SizedBox(height: 10),
          Text('Gender'),
          Row(
            children: [
              Expanded(child: RadioListTile<String>(
                title: Text('Male'),
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              )),
              Expanded(child: RadioListTile<String>(
                title: Text('Female'),
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              )),
              Expanded(child: RadioListTile<String>(
                title: Text('Other'),
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              )),
            ],
          ),
          SizedBox(height: 10),
          _buildTextField('Email Address', _emailController),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            child: AbsorbPointer(
              child: _buildTextField(
                'Date of Birth',
                TextEditingController(
                  text: _selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : '',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildTextField('Birth Place', _birthPlaceController),
        ],
      ),
    );
  }

  Widget _buildContactInformationSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Information', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10),
          _buildTextField('Phone Number', _phoneNumberController),
          _buildTextField('WhatsApp Number', _whatsappNumberController),
        ],
      ),
    );
  }

  Widget _buildEducationalInformationSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Educational Information', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10),
          _buildTextField('College Name', _collegeNameController),
          _buildTextField('College\'s State', _collegeStateController),
          _buildTextField('Branch', _branchNameController),
          _buildTextField('Degree', _degreeNameController),
          _buildTextField('Passout Year', _passingYearController),
        ],
      ),
    );
  }

  Widget _buildPasswordSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Let\'s Create Password', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 10),
          _buildPasswordField('Password', _passwordController),
          _buildPasswordField('Confirm Password', _confirmPasswordController),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? prefixText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextFormField(
      obscureText: label == 'Password' ? _obscurePassword : _obscureConfirmPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            label == 'Password'
                ? _obscurePassword ? Icons.visibility_off : Icons.visibility
                : _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              if (label == 'Password') {
                _obscurePassword = !_obscurePassword;
              } else {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              }
            });
          },
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

Future<void> _register() async {
  if (_formKey.currentState?.validate() ?? false) {
    try {
      final response = await http.post(
        Uri.parse('http://13.127.246.196:8000/api/registers/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'full_name': _fullNameController.text,
          'father_name': _fatherNameController.text,
          'email': _emailController.text,
          'phone_number': _phoneNumberController.text,
          'whatsapp_number': _whatsappNumberController.text,
          'birth_place': _birthPlaceController.text,
          'college_name': _collegeNameController.text,
          'college_state': _collegeStateController.text,
          'branch_name': _branchNameController.text,
          'degree_name': _degreeNameController.text,
          'passing_year': _passingYearController.text,
          'password': _passwordController.text,
          'gender': _selectedGender,
          'date_of_birth': _selectedDate != null ? _selectedDate!.toIso8601String() : '',
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context);
      } else {
        final responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${responseBody['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
}
