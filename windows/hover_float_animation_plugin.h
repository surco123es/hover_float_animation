#ifndef FLUTTER_PLUGIN_HOVER_FLOAT_ANIMATION_PLUGIN_H_
#define FLUTTER_PLUGIN_HOVER_FLOAT_ANIMATION_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace hover_float_animation {

class HoverFloatAnimationPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  HoverFloatAnimationPlugin();

  virtual ~HoverFloatAnimationPlugin();

  // Disallow copy and assign.
  HoverFloatAnimationPlugin(const HoverFloatAnimationPlugin&) = delete;
  HoverFloatAnimationPlugin& operator=(const HoverFloatAnimationPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace hover_float_animation

#endif  // FLUTTER_PLUGIN_HOVER_FLOAT_ANIMATION_PLUGIN_H_
