import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Helper utility for authentication checks in the checkout/purchase flow
class AuthCheckHelper {
  /// Verify if user is logged in by checking if a Client exists
  /// If not logged in, show a dialog with [message] and navigate to login page
  /// Returns true if user is authenticated, false otherwise
  static Future<bool> verifyAndAuthenticateUser(
    BuildContext context, {
    String? message,
  }) async {
    Future<bool> isAuthenticated() async {
      final String? token = await SecureStorageHelper.getToken();
      final String? client = await SecureStorageHelper.getClient();

      final bool isAuthenticated = (token != null && token.isNotEmpty) ||
          (client != null && client.isNotEmpty);
      log('wtffffff helll $isAuthenticated');

      return isAuthenticated;
    }

    // Check if user is logged in by retrieving stored client
    final bool authenticated = await isAuthenticated();

    if (!authenticated) {
      if (context.mounted && message != null) {
        await _showAuthMessageDialog(context, message);
      }

      // Use ROOT navigator instead of widget context
      final navContext = rootNavKey?.currentState?.context;
      if (navContext != null && navContext.mounted) {
        try {
          // navContext.pushNamed(loginRouteName);
        } catch (e) {
          log(' ✅😡$e');
        }
      }

      return await isAuthenticated();
    }

    // User is already authenticated
    return true;
  }

  /// Show a dialog with a message that auto-dismisses after 3 seconds
  /// User can also click OK to dismiss immediately and proceed to login
  static Future<void> _showAuthMessageDialog(
    BuildContext context,
    String message,
  ) async {
    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context)!;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        // Auto-close after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.borderRadius),
          ),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary),
              Gap.horizontal(width: Dimens.spacing),
              Expanded(
                child: Text(
                  l10n.authenticationRequired,
                  style: AppTheme.lightTextTheme.displayLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: AppTheme.lightTextTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: AppColors.grey1,
            ),
          ),
          actions: [
            PrimaryButton(
                withBg: false,
                inkRaduis: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                buttonColor: AppColors.primary,
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Text(
                    l10n.ok,
                    style: AppTheme.lightTextTheme.displayMedium!
                        .copyWith(color: AppColors.white1, fontSize: 14),
                  ),
                )),
          ],
        );
      },
    );
  }
}
