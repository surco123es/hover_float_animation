//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <animation_transition/animation_transition_plugin.h>
#include <hover_float_animation/hover_float_animation_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) animation_transition_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AnimationTransitionPlugin");
  animation_transition_plugin_register_with_registrar(animation_transition_registrar);
  g_autoptr(FlPluginRegistrar) hover_float_animation_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HoverFloatAnimationPlugin");
  hover_float_animation_plugin_register_with_registrar(hover_float_animation_registrar);
}
