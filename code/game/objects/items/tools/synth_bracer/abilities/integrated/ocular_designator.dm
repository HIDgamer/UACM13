


/datum/action/human_action/synth_bracer/deploy_binoculars
	name = "Deploy Binoculars"
	action_icon_state = "far_sight"
	human_adaptable = TRUE

/datum/action/human_action/synth_bracer/deploy_ocular_binos/can_use_action()
	if(QDELETED(synth_bracer.binos) || synth_bracer.binos.loc != synth_bracer)
		to_chat(synth, SPAN_WARNING("The ocular device isn't inside the SIMI anymore."))
		return FALSE
	if(synth.l_hand && synth.r_hand)
		to_chat(synth, SPAN_WARNING("You need at least one free hand."))
		return FALSE
	return ..()

/datum/action/human_action/synth_bracer/deploy_binoculars/action_activate()
	..()
	if(COOLDOWN_FINISHED(synth_bracer, sound_cooldown))
		COOLDOWN_START(synth_bracer, sound_cooldown, 5 SECONDS)
		playsound(synth_bracer.loc,'sound/machines/click.ogg', 25, TRUE)
	if(synth_bracer.binos.loc == synth_bracer)
		to_chat(synth, SPAN_NOTICE("You deploy your binoculars."))
		synth_bracer.deploy_binos(synth)
	else
		to_chat(synth, SPAN_NOTICE("You return your binoculars."))
		synth_bracer.return_binos(synth)
