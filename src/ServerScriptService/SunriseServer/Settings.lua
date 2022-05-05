return {
	loader = {
		sendErrorsAsUI = false; --false

	}; --Anything to do with how the loader is handled eg usingKnit allows the knit framework to be used

	permissions = {
		
		holders = {
			['OlixerYT'] = "full", --This is my profile, there are 3 permission types, full, partial, minimal(Only put the person's name!)
		}; --This holds all the people and their permission you dont have to worry about reading anything from here the library does it all for you ;)

		permissionNodes = {
			['getUiErrors'] = "full",
		}; --This has all the permission nodes saved with the permission level someone needs to use this

		tempNodes = {

		}; --This is the same as permissionNodes but temp permissions will be set here from the library, please dont put anything here as the lib will error!
		
	}; --Used to give permissions to manage the framework(Only give their user id and not the user!)

	extends = {}; --Allows for the addition any extends

	custom = {}; --This allows to make your own settings for expansions etc
}

