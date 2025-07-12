

/datum/action/human_action/synth_bracer/motion_detector
	name = "Toggle Motion Detector"
	action_icon_state = "motion_detector"
	handles_charge_cost = TRUE
	handles_cooldown = TRUE
	charge_cost = 2
	human_adaptable = TRUE

/datum/action/human_action/synth_bracer/motion_detector/action_activate()
	..()
	synth_bracer.toggle_motion_detector(synth)

/datum/action/human_action/synth_bracer/motion_detector/proc/update_icon()
	if(!synth_bracer)
		return

	if(synth_bracer.motion_detector_active)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"
