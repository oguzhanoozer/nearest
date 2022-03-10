#flutter pub run easy_localization:generate  -O lib/core/init/lang -f keys -o locale_keys.g.dart --source-dir asset/lang

flutter pub run easy_localization:generate -S "asset/lang" -O "lib/core/init/lang"


flutter pub run easy_localization:generate -S "asset/lang" -O "lib/core/init/lang" -o "locale_keys.g.dart" -f keys