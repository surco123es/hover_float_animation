#include "include/hover_float_animation/hover_float_animation_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hover_float_animation_plugin.h"

void HoverFloatAnimationPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hover_float_animation::HoverFloatAnimationPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
