//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <animation_transition/animation_transition_plugin_c_api.h>
#include <hover_float_animation/hover_float_animation_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AnimationTransitionPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AnimationTransitionPluginCApi"));
  HoverFloatAnimationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("HoverFloatAnimationPluginCApi"));
}
