// ignore_for_file: constant_identifier_names

import 'package:logger/logger.dart';

export './network/params.dart';
export './network/repository.dart';

export './support_files/theme.dart';
export './support_files/assets.gen.dart';

export './app/routes/app_pages.dart';

export './common/widgets/app_bar.dart';
export './common/widgets/data_scaffold.dart';
export './common/widgets/empty_data_view.dart';
export './common/widgets/network_image_view.dart';
export './common/widgets/toast.dart';
export './common/widgets/primary_button.dart';

export './common/refresh/refresh.dart';

export './common/extensions/custom_scroll_extension.dart';


final logger = Logger();

/// deep link
const String kUrlScheme = 'example://test';
