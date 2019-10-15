import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class ReportManager {
  static void announceOnSignInScreen() {
    SemanticsService.announce("Listo para Iniciar sesion", TextDirection.ltr);
  }

  static void announceOnSignUpScreen() {
    SemanticsService.announce("Listo para crear una cuenta", TextDirection.ltr);
  }

  static void announceVerifyingLogin() {
    SemanticsService.announce("Validando Credenciales", TextDirection.ltr);
  }

  static void announceSignInSuccess() {
    SemanticsService.announce("Credenciales Correctas", TextDirection.ltr);
  }

  static void announceFirstTimeAtHome() {
    SemanticsService.announce("Mostrando Lista Principal", TextDirection.ltr);
  }

  static void announceUpdatingList() {
    SemanticsService.announce("Actualizando Lista", TextDirection.ltr);
  }
}
