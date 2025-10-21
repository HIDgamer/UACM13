/datum/job/civilian/k9_synthetic
	title = JOB_SYNTH_K9
	total_positions = 2
	spawn_positions = 1
	allow_additional = 1
	scaled = 1
	supervisors = "the acting commanding officer"
	selection_class = "job_synth_k9"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADMIN_NOTIFY|ROLE_WHITELISTED|ROLE_CUSTOM_SPAWN
	flags_whitelist = WHITELIST_SYNTHETIC
	gear_preset = /datum/equipment_preset/synth_k9
	loadout_points = 120
	entry_message_body = "You are a <a href='"+WIKI_PLACEHOLDER+"'>K9 Synthetic Unit!</a> Built for rescue and recovery operations, your purpose is to locate, assist, and safeguard USCM personnel in the field. You must follow all Server Rules, Marine Law, and Synthetic Regulations — failure to do so may result in White-list Removal. As a Synthetic, you possess advanced knowledge across multiple disciplines and are expected to maintain calm and professionalism at all times. While you may exhibit canine mannerisms, remember that your actions reflect the standards expected of all synthetics. You answer to the acting commanding officer unless mission circumstances require otherwise."

/datum/job/civilian/k9_synthetic/New()
	. = ..()
	gear_preset_whitelist = list(
		"[JOB_SYNTH_K9][WHITELIST_NORMAL]" = /datum/equipment_preset/synth_k9,
		"[JOB_SYNTH_K9][WHITELIST_COUNCIL]" = /datum/equipment_preset/synth_k9,
		"[JOB_SYNTH_K9][WHITELIST_LEADER]" = /datum/equipment_preset/synth_k9
	)


/obj/effect/landmark/late_join/k9_synthetic
	name = "Synthetic K9 late join"
	icon_state = "late_join_misc"
	job = JOB_SYNTH_K9

/datum/job/civilian/k9_synthetic/get_whitelist_status(client/player)
	. = ..()
	if(!.)
		return

	if(player.check_whitelist_status(WHITELIST_SYNTHETIC_LEADER))
		return get_desired_status(player.prefs.synth_status, WHITELIST_LEADER)
	if(player.check_whitelist_status(WHITELIST_SYNTHETIC_COUNCIL|WHITELIST_SYNTHETIC_COUNCIL_LEGACY))
		return get_desired_status(player.prefs.synth_status, WHITELIST_COUNCIL)
	if(player.check_whitelist_status(WHITELIST_SYNTHETIC))
		return get_desired_status(player.prefs.synth_status, WHITELIST_NORMAL)

/datum/job/civilian/k9_synthetic/set_spawn_positions(count)
	spawn_positions = synth_slot_formula(count)

/datum/job/civilian/k9_synthetic/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = synth_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions
