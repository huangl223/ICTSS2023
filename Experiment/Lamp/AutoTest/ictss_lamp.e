note
	description: "This class implements a lamp that contains a dimmer. "

class
	ICTSS_LAMP

create
	make

feature
	make
		do
			print ("branch 0%N")
		end

feature

	light_intensity: INTEGER
			-- Light intensity of the lamp

	is_on: BOOLEAN
			-- Is the lamp on?

	previous_light_intensity: INTEGER
			-- Light intensity of the lamp before it was last turned off

	High_intensity: INTEGER = 100
			-- High light intensity

	Medium_intensity: INTEGER = 75
			-- Medium light intensity

	Low_intensity: INTEGER = 25
			-- Low light intensity

	Zero_intensity: INTEGER = 0
			-- Zero light intensity

feature

	turn_on_off
			-- Turn on the lamp if it is off; turn off the lamp if it is on
		do
			if not is_on then
				is_on := True
				if previous_light_intensity > 0 then -- branch1
					print ("branch 1%N")
					light_intensity := previous_light_intensity
				else -- branch2
					print ("branch 2%N")
					light_intensity := Low_intensity
				end
			else -- branch 3
				print ("branch 3%N")
				is_on := False
				previous_light_intensity := light_intensity
				light_intensity := Zero_intensity
			end
		ensure
			lamp_is_turned_on: (old (not is_on and previous_light_intensity > 0) implies (is_on and light_intensity = old previous_light_intensity))
				and (old (not is_on and previous_light_intensity = 0) implies (is_on and light_intensity = Low_intensity))
			lamp_is_turned_off: old is_on implies (not is_on and previous_light_intensity = old light_intensity and light_intensity = Zero_intensity)
		end

	adjust_light
			-- Adjust the light intensity
		require
			lamp_is_on: is_on = True
		do
			if light_intensity = Low_intensity then -- branch1
				print ("branch 4%N")
				light_intensity := Medium_intensity
			elseif light_intensity = Medium_intensity then -- branch2
				print ("branch 5%N")
				light_intensity := High_intensity
			elseif light_intensity = High_intensity then -- branch3
				print ("branch 6%N")
				light_intensity := Low_intensity
			else -- branch 4 (not reachable)
				print ("branch 7%N")
			end
		ensure
			from_low_to_medium: old light_intensity = Low_intensity implies light_intensity = Medium_intensity
			from_medium_to_high: old light_intensity = Medium_intensity implies light_intensity = High_intensity
			from_high_to_low: old light_intensity = High_intensity implies light_intensity = Low_intensity
		end

invariant
	value_of_light_intensity: light_intensity = Zero_intensity or light_intensity = Low_intensity
		or light_intensity = Medium_intensity or light_intensity = High_intensity
	value_of_previous_intensity: previous_light_intensity = Zero_intensity or previous_light_intensity = Low_intensity
		or previous_light_intensity = Medium_intensity or previous_light_intensity = High_intensity
	light_intensity_when_off: is_on = (light_intensity /= Zero_intensity)

end
