import 'package:flutter/material.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.vm});

  final LoginViewModel vm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: vm.emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return '유효한 이메일을 입력해주세요.';
        }
        return null;
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key, required this.vm});

  final LoginViewModel vm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: vm.pwController,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 6) {
          return '비밀번호는 6자 이상이어야 합니다.';
        }
        return null;
      },
    );
  }
}

class SignUpUserNameTextField extends StatelessWidget {
  const SignUpUserNameTextField({
    super.key,
    required TextEditingController usernameController,
  }) : _usernameController = usernameController;

  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'UserName',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '사용자 이름을 입력해주세요.';
        }
        return null;
      },
    );
  }
}

class SignUpEmailTextField extends StatelessWidget {
  const SignUpEmailTextField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return '유효한 이메일을 입력해주세요.';
        }
        return null;
      },
    );
  }
}

class SignUpPasswordTextField extends StatelessWidget {
  const SignUpPasswordTextField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 6) {
          return '비밀번호는 6자 이상이어야 합니다.';
        }
        return null;
      },
    );
  }
}
