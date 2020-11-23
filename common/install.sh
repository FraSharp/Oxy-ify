ORIGDIR=/sbin/.magisk/mirror
FONTDIR=$MODPATH/system/oneplussans
SYSFONT=$MODPATH/system/fonts
PRDFONT=$MODPATH/system/product/fonts
SYSETC=$MODPATH/system/etc
SYSXML=$SYSETC/fonts.xml
MODPROP=$MODPATH/module.prop

patch() {
	cp $ORIGDIR/system/etc/fonts.xml $SYSXML
	sed -i '/"sans-serif">/,/family>/H;1,/family>/{/family>/G}' $SYSXML
	sed -i ':a;N;$!ba;s/name="sans-serif"//2' $SYSXML
	sed -i '/"sans-serif">/,/family>/{s/Roboto-M/M/;s/Roboto-B/B/}' $SYSXML
    sed -i '/"sans-serif">/,/family>/{s/Roboto-T/T/;s/Roboto-L/L/;s/Roboto-R/R/;s/Roboto-I/I/}' $SYSXML	
	sed -i 's/RobotoC/C/' $SYSXML
}

headline() {
	cp $FONTDIR/OnePlusSans-Black.ttf $SYSFONT/Black.ttf;
	cp $FONTDIR/OnePlusSans-BlackItalic.ttf $SYSFONT/BlackItalic.ttf;
	cp $FONTDIR/OnePlusSans-Bold.ttf $SYSFONT/Bold.ttf;
	cp $FONTDIR/OnePlusSans-BoldItalic.ttf $SYSFONT/BoldItalic.ttf;
	cp $FONTDIR/OnePlusSans-Medium.ttf $SYSFONT/Medium.ttf;
	cp $FONTDIR/OnePlusSans-MediumItalic.ttf $SYSFONT/MediumItalic.ttf;
}

body() {
	cp $FONTDIR/OnePlusSans-Italic.ttf $SYSFONT/Italic.ttf;
	cp $FONTDIR/OnePlusSans-Light.ttf $SYSFONT/Light.ttf;
	cp $FONTDIR/OnePlusSans-LightItalic.ttf $SYSFONT/LightItalic.ttf;
	cp $FONTDIR/OnePlusSans-Regular.ttf $SYSFONT/Regular.ttf;
	cp $FONTDIR/OnePlusSans-Thin.ttf 
$SYSFONT/Thin.ttf
	cp $FONTDIR/OnePlusSans-ThinItalic.ttf $SYSFONT/ThinItalic.ttf;	
}

condensed() {
    cp $FONTDIR/OnePlusSans-Regular.ttf $SYSFONT/Condensed-Regular.ttf;
	cp $FONTDIR/OnePlusSans-Italic.ttf $SYSFONT/Condensed-Italic.ttf;
	cp $FONTDIR/OnePlusSans-Bold.ttf $SYSFONT/Condensed-Bold.ttf;
	cp $FONTDIR/OnePlusSans-BoldItalic.ttf $SYSFONT/Condensed-BoldItalic.ttf;	
	cp $FONTDIR/OnePlusSans-Light.ttf $SYSFONT/Condensed-Light.ttf;
	cp $FONTDIR/OnePlusSans-LightItalic.ttf $SYSFONT/Condensed-LightItalic.ttf;
	cp $FONTDIR/OnePlusSans-Medium.ttf $SYSFONT/Condensed-Medium.ttf;
	cp $FONTDIR/OnePlusSans-MediumItalic.ttf $SYSFONT/Condensed-MediumItalic.ttf;		
}

full() { headline; body; condensed; }

clean_up() {
	rm -rf $FONTDIR
	rmdir -p $SYSETC $PRDFONT
}

pixel() {
	if [ -f /product/fonts/GoogleSans-Regular.ttf ]; then
		DEST=$PRDFONT
	elif [ -f /system/fonts/GoogleSans-Regular.ttf ]; then
		DEST=$SYSFONT
	fi
	if [ ! -z $DEST ]; then
		cp $FONTDIR/OnePlusSans-Regular.ttf $DEST/GoogleSans-Regular.ttf
		cp $FONTDIR/OnePlusSans-Italic.ttf $DEST/GoogleSans-Italic.ttf
		cp $FONTDIR/OnePlusSans-Medium.ttf $DEST/GoogleSans-Medium.ttf
		cp $FONTDIR/OnePlusSans-MediumItalic.ttf $DEST/GoogleSans-MediumItalic.ttf
		cp $FONTDIR/OnePlusSans-Bold.ttf $DEST/GoogleSans-Bold.ttf
		cp $FONTDIR/OnePlusSans-BoldItalic.ttf $DEST/GoogleSans-BoldItalic.ttf
		sed -ie 3's/$/+PXL&/' $MODPROP
		PXL=true
	fi
}

oxygen() {
	if [ -f $ORIGDIR/system/fonts/OnePlusSans-Regular.ttf ]; then
		cp $SYSFONT/Black.ttf $SYSFONT/OnePlusSans-Black.ttf
		cp $SYSFONT/Bold.ttf $SYSFONT/OnePlusSans-Bold.ttf
		cp $SYSFONT/Medium.ttf $SYSFONT/OnePlusSans-Medium.ttf
		cp $SYSFONT/Regular.ttf $SYSFONT/OnePlusSans-Regular.ttf
		cp $SYSFONT/Regular.ttf $SYSFONT/OnePlusSans-Book.ttf
		cp $SYSFONT/Light.ttf $SYSFONT/OnePlusSans-Light.ttf
		cp $SYSFONT/Thin.ttf $SYSFONT/OnePlusSans-Thin.ttf
		sed -ie 3's/$/+OOS&/' $MODPROP
		OOS=true
	fi
}

miui() {
	if i=$(grep miui $SYSXML); then
	    sed -i '/"mipro"/,/family>/{/400/s/MiLanProVF/Regular/;/stylevalue="340"/d}' $SYSXML
		sed -i '/"mipro-thin"/,/family>/{/400/s/MiLanProVF/Thin/;/700/s/MiLanProVF/Light/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-extralight"/,/family>/{/400/s/MiLanProVF/Thin/;/700/s/MiLanProVF/Light/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-light"/,/family>/{/400/s/MiLanProVF/Light/;/700/s/MiLanProVF/Regular/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-normal"/,/family>/{/400/s/MiLanProVF/Light/;/700/s/MiLanProVF/Regular/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-regular"/,/family>/{/400/s/MiLanProVF/Regular/;/stylevalue="340"/d}' $SYSXML		
		sed -i '/"mipro-medium"/,/family>/{/400/s/MiLanProVF/Medium/;/700/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-demibold"/,/family>/{/400/s/MiLanProVF/Medium/;/700/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-semibold"/,/family>/{/400/s/MiLanProVF/Medium/;/700/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-bold"/,/family>/{/400/s/MiLanProVF/Bold/;/700/s/MiLanProVF/Black/;/stylevalue/d}' $SYSXML
		sed -i '/"mipro-heavy"/,/family>/{/400/s/MiLanProVF/Black/;/stylevalue/d}' $SYSXML        	
		sed -ie 3's/$/+Miui&/' $MODPROP
		MIUI=true
	fi
}

lg() {
	if i=$(grep lg-sans-serif $SYSXML); then
		sed -i '/"lg-sans-serif">/,/family>/{/"lg-sans-serif">/!d};/"sans-serif">/,/family>/{/"sans-serif">/!H};/"lg-sans-serif">/G' $SYSXML
		LG=true
	fi
	if [ -f $ORIGDIR/system/etc/fonts_lge.xml ]; then
		cp $ORIGDIR/system/etc/fonts_lge.xml $SYSETC
		LGXML=$SYSETC/fonts_lge.xml
		sed -i '/"default_roboto">/,/family>/{s/Roboto-M/M/;s/Roboto-B/B/Roboto-T/T/;s/Roboto-L/L/;s/Roboto-R/R/;s/Roboto-I/I/}' $LGXML		
		LG=true
	fi
	if $LG; then sed -ie 3's/$/+LG&/' $MODPROP; fi
}

rom() {
	pixel
	if ! $PXL; then oxygen
		if ! $OOS; then miui
			if ! $MIUI; then lg
			fi
		fi
	fi
}






ui_print " "
ui_print " - Font Option -"
ui_print " *******************************************"
ui_print "   Do you want OnePlus Slate font?"
ui_print "   Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
  ui_print "   Enabling font..."
else
  ui_print "   Disabling font..."
  rm -rf $MODPATH/system/fonts
fi


ui_print " "
ui_print " - Font Option -"
ui_print " *******************************************"
ui_print "   Do you want OnePlus Sans font?"
ui_print "   Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
  ui_print "   Enabling font..."
  mkdir -p $SYSFONT $SYSETC $PRDFONT
patch

full

PXL=false; OOS=false; MIUI=false; LG=false
rom
sleep 1
clean_up
else
  ui_print "   Disabling font..."
  rm -rf $MODPATH/system/oneplussans
fi


ui_print " "
ui_print " - Media Option -"
ui_print " *******************************************"
ui_print "   Do you want Oxygen OS custom media sounds?"
ui_print "   They include ringtones, alarms, notifications"
ui_print "   Vol Up = Yes, Vol Down = No"
ui_print " "
if $VKSEL; then
  ui_print "    Enabling custom media sounds... "
else
  ui_print "    Disabling custom media sounds... "
  rm -rf $MODPATH/system/media $MODPATH/system.prop
fi

if [ $API -ge 27 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Gallery?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  ui_print " "
  if $VKSEL; then
    ui_print "   Enabling OnePlus Gallery..."
 else
    ui_print "   Disabling OnePlus Gallery..."
    rm -rf $MODPATH/system/app/OPGallery
  fi
fi

if [ $API -ge 24] && [ $API -le 28 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Screen Recorder?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  if $VKSEL; then
    ui_print "   Enabling OnePlus Screen Recorder..."
  else
    ui_print "   Disabling OnePlus Screen Recorder..."
    rm -rf $MODPATH/system/app/OPScreenRecorder
  fi
else
  rm -rf $MODPATH/system/app/OPScreenRecorder
fi

if [ $API -ge 24 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Camera?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  if $VKSEL; then
    ui_print "   Enabling OnePlus Camera..."
  else
    ui_print "   Disabling OnePlus Camera..."
    rm -rf $MODPATH/system/app/OPCamera
  fi
else
  rm -rf $MODPATH/system/app/OPCamera
fi

if [ $API -ge 23 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Sound Recorder?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  if $VKSEL; then
    ui_print "   Enabling OnePlus Sound Recorder..."
  else
    ui_print "   Disabling OnePlus Sound Recorder..."
    rm -rf $MODPATH/system/app/OPSoundRecorder
  fi
else
  rm -rf $MODPATH/system/app/OPSoundRecorder
fi

if [ $API -ge 25 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Weather and Widget?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  if $VKSEL; then
    ui_print "   Enabling OnePlus Weather..."
    ui_print "   Enabling OnePlus Widget..."
  else
    ui_print "   Disabling OnePlus Weather..."
    rm -rf $MODPATH/system/app/OPWeather
    rm -rf $MODPATH/system/app/OPWidget
  fi
else
  rm -rf $MODPATH/system/app/OPWeather
  rm -rf $MODPATH/system/app/OPWidget
fi

if [ $API -ge 23 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Calculator?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  if $VKSEL; then
    ui_print "   Enabling OnePlus Calculator..."
  else
    ui_print "   Disabling OnePlus Calculator..."
    rm -rf $MODPATH/system/app/OPCalculator
  fi
else
  rm -rf $MODPATH/system/app/OPCalculator
fi

if [ $API -ge 28 ]; then
  ui_print " "
  ui_print " *******************************************"
  ui_print "   Do you want OnePlus Wallpapers?"
  ui_print "   Vol Up = Yes, Vol Down = No"
  ui_print " "
  if $VKSEL; then
    ui_print "   Enabling OnePlus Wallpapers..."
 else
    ui_print "   Disabling OnePlus Wallpapers..."
    rm -rf $MODPATH/system/app/OPWallpapers
  fi
fi
