//woof!
/datum/species/synthetic/synth_k9
	name = SPECIES_SYNTHETIC_K9

	slowdown = -1.75 //Faster than Human run, slower than rooney run
	shoes_affect_speed = FALSE // Boots don't affect speed, preventing the mega speed boost when wearing boots

	icobase = 'icons/mob/humans/species/synth_k9/r_k9.dmi'
	deform = 'icons/mob/humans/species/synth_k9/r_k9.dmi'
	eyes = "blank_eyes_s"
	blood_mask = 'icons/mob/humans/species/synth_k9/r_k9.dmi'
	unarmed_type = /datum/unarmed_attack/bite/synthetic
	secondary_unarmed_type = /datum/unarmed_attack
	death_message = "lets out a faint whimper as it collapses and stops moving..."
	flags = IS_WHITELISTED|NO_BREATHE|NO_CLONE_LOSS|NO_BLOOD|NO_POISON|IS_SYNTHETIC|NO_CHEM_METABOLIZATION|NO_NEURO|NO_OVERLAYS

	mob_inherent_traits = list(TRAIT_SUPER_STRONG, TRAIT_IRON_TEETH, TRAIT_EMOTE_CD_EXEMPT)

	fire_sprite_prefix = "k9"
	fire_sprite_sheet = 'icons/mob/humans/onmob/OnFire.dmi'

	inherent_verbs = list(
		/mob/living/carbon/human/synthetic/proc/toggle_HUD,
		/mob/living/carbon/human/proc/toggle_inherent_nightvison,
		/mob/living/carbon/human/synthetic/synth_k9/proc/toggle_scent_tracking,
		/mob/living/carbon/human/synthetic/synth_k9/proc/toggle_binocular_vision,
	)

	//Scent tracking
	var/datum/radar/scenttracker/radar
	var/faction = FACTION_MARINE

//Lets have a place for radar data to live
/datum/species/synthetic/synth_k9/handle_post_spawn(mob/living/carbon/human/spawned_k9)
	. = ..()
	radar = new /datum/radar/scenttracker(spawned_k9, faction)

/datum/species/synthetic/synth_k9/Destroy()
	. = ..()
	qdel(radar)
	faction = null

/// Override to always show overlays for head, feet, and mask slots
/// This allows the K9 to wear those items and show their visuals
/datum/species/synthetic/synth_k9/should_show_overlay(slot)
	switch(slot)
		if(WEAR_HEAD, WEAR_FEET, WEAR_FACE)
			return TRUE
		else
			return ..()

/// Modify overlays for specific slots to use K9-specific icon states
/// Head slot gets beret_k9, feet slot gets boots_k9, face slot gets scarf_k9
/datum/species/synthetic/synth_k9/modify_overlay(image/overlay, slot)
	overlay.icon = 'icons/mob/humans/species/synth_k9/onmob/synth_k9_overlays.dmi'
	switch(slot)
		if(WEAR_HEAD)
			overlay.icon_state = "beret_k9"
		if(WEAR_FEET)
			overlay.icon_state = "boots_k9"
		if(WEAR_FACE)
			overlay.icon_state = "scarf_k9"
	return overlay

/// Override to use K9-specific wound overlay icon states
/// Uses the species blood_mask for the icon
/datum/species/synthetic/synth_k9/get_wound_overlay_icon_state(icon_name, state)
	return "wound_[state]"

/// Override to use K9-specific burn overlay icon states
/// Uses the species blood_mask for the icon
/datum/species/synthetic/synth_k9/get_burn_overlay_icon_state(icon_name, state)
	return "wound_[state]"
