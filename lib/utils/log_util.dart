// file: log_util.dart
// date: Nov/25/2021
// brief: A class for gea log.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:commonlogging/common_logging.dart';

var geaLog = GeaLog(
    GeaLogProperties(
        baseLogLevel: LogLevel.debug,  // Messages with a log level lower than this base log level are not logged
        logHeader: "SmartHQ Project"), // It's displayed at the very beginning of the log start.
    printers: [ConsolePrinter()], // Target printer for log output
    forcedPrintLog: BuildEnvironment.forceLog ?? true); // Logging regardless of build type