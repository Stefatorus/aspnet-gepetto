; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [313 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [626 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 67
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 66
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 107
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 236
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 270
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 47
	i32 38948123, ; 6: ar\Microsoft.Maui.Controls.resources.dll => 0x2524d1b => 278
	i32 39485524, ; 7: System.Net.WebSockets.dll => 0x25a8054 => 79
	i32 42244203, ; 8: he\Microsoft.Maui.Controls.resources.dll => 0x284986b => 287
	i32 42639949, ; 9: System.Threading.Thread => 0x28aa24d => 144
	i32 66541672, ; 10: System.Diagnostics.StackTrace => 0x3f75868 => 29
	i32 67008169, ; 11: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 311
	i32 68219467, ; 12: System.Security.Cryptography.Primitives => 0x410f24b => 123
	i32 72070932, ; 13: Microsoft.Maui.Graphics.dll => 0x44bb714 => 193
	i32 82292897, ; 14: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 101
	i32 83839681, ; 15: ms\Microsoft.Maui.Controls.resources.dll => 0x4ff4ac1 => 295
	i32 98325684, ; 16: Microsoft.Extensions.Diagnostics.Abstractions => 0x5dc54b4 => 180
	i32 101534019, ; 17: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 254
	i32 117431740, ; 18: System.Runtime.InteropServices => 0x6ffddbc => 106
	i32 120558881, ; 19: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 254
	i32 122350210, ; 20: System.Threading.Channels.dll => 0x74aea82 => 138
	i32 134690465, ; 21: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 274
	i32 136584136, ; 22: zh-Hans\Microsoft.Maui.Controls.resources.dll => 0x8241bc8 => 310
	i32 140062828, ; 23: sk\Microsoft.Maui.Controls.resources.dll => 0x859306c => 303
	i32 142721839, ; 24: System.Net.WebHeaderCollection => 0x881c32f => 76
	i32 149972175, ; 25: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 123
	i32 159306688, ; 26: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 27: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 210
	i32 176265551, ; 28: System.ServiceProcess => 0xa81994f => 131
	i32 182336117, ; 29: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 256
	i32 184328833, ; 30: System.ValueTuple.dll => 0xafca281 => 150
	i32 205061960, ; 31: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 32: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 208
	i32 220171995, ; 33: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 221958352, ; 34: Microsoft.Extensions.Diagnostics.dll => 0xd3ad0d0 => 179
	i32 230216969, ; 35: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 230
	i32 230752869, ; 36: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 37: System.Linq.Parallel => 0xdcb05c4 => 58
	i32 231814094, ; 38: System.Globalization => 0xdd133ce => 41
	i32 246610117, ; 39: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 90
	i32 247980345, ; 40: GPTAndroid => 0xec7e139 => 0
	i32 261689757, ; 41: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 213
	i32 276479776, ; 42: System.Threading.Timer.dll => 0x107abf20 => 146
	i32 278686392, ; 43: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 232
	i32 280482487, ; 44: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 229
	i32 291076382, ; 45: System.IO.Pipes.AccessControl.dll => 0x1159791e => 53
	i32 291275502, ; 46: Microsoft.Extensions.Http.dll => 0x115c82ee => 181
	i32 298918909, ; 47: System.Net.Ping.dll => 0x11d123fd => 68
	i32 317674968, ; 48: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 308
	i32 318968648, ; 49: Xamarin.AndroidX.Activity.dll => 0x13031348 => 199
	i32 321597661, ; 50: System.Numerics => 0x132b30dd => 82
	i32 321963286, ; 51: fr\Microsoft.Maui.Controls.resources.dll => 0x1330c516 => 286
	i32 342366114, ; 52: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 231
	i32 360082299, ; 53: System.ServiceModel.Web => 0x15766b7b => 130
	i32 367780167, ; 54: System.IO.Pipes => 0x15ebe147 => 54
	i32 374914964, ; 55: System.Transactions.Local => 0x1658bf94 => 148
	i32 375677976, ; 56: System.Net.ServicePoint.dll => 0x16646418 => 73
	i32 379916513, ; 57: System.Threading.Thread.dll => 0x16a510e1 => 144
	i32 385762202, ; 58: System.Memory.dll => 0x16fe439a => 61
	i32 392610295, ; 59: System.Threading.ThreadPool.dll => 0x1766c1f7 => 145
	i32 395744057, ; 60: _Microsoft.Android.Resource.Designer => 0x17969339 => 312
	i32 403441872, ; 61: WindowsBase => 0x180c08d0 => 164
	i32 409257351, ; 62: tr\Microsoft.Maui.Controls.resources.dll => 0x1864c587 => 306
	i32 441335492, ; 63: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 214
	i32 442565967, ; 64: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 65: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 227
	i32 451504562, ; 66: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 124
	i32 456227837, ; 67: System.Web.HttpUtility.dll => 0x1b317bfd => 151
	i32 459347974, ; 68: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 112
	i32 465846621, ; 69: mscorlib => 0x1bc4415d => 165
	i32 469710990, ; 70: System.dll => 0x1bff388e => 163
	i32 476646585, ; 71: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 229
	i32 486930444, ; 72: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 242
	i32 489220957, ; 73: es\Microsoft.Maui.Controls.resources.dll => 0x1d28eb5d => 284
	i32 498788369, ; 74: System.ObjectModel => 0x1dbae811 => 83
	i32 513247710, ; 75: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 187
	i32 526420162, ; 76: System.Transactions.dll => 0x1f6088c2 => 149
	i32 527452488, ; 77: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 274
	i32 530272170, ; 78: System.Linq.Queryable => 0x1f9b4faa => 59
	i32 538707440, ; 79: th\Microsoft.Maui.Controls.resources.dll => 0x201c05f0 => 305
	i32 539058512, ; 80: Microsoft.Extensions.Logging => 0x20216150 => 182
	i32 540030774, ; 81: System.IO.FileSystem.dll => 0x20303736 => 50
	i32 545304856, ; 82: System.Runtime.Extensions => 0x2080b118 => 102
	i32 546455878, ; 83: System.Runtime.Serialization.Xml => 0x20924146 => 113
	i32 549171840, ; 84: System.Globalization.Calendars => 0x20bbb280 => 39
	i32 557405415, ; 85: Jsr305Binding => 0x213954e7 => 267
	i32 569601784, ; 86: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 265
	i32 577335427, ; 87: System.Security.Cryptography.Cng => 0x22697083 => 119
	i32 601371474, ; 88: System.IO.IsolatedStorage.dll => 0x23d83352 => 51
	i32 605376203, ; 89: System.IO.Compression.FileSystem => 0x24154ecb => 43
	i32 613668793, ; 90: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 118
	i32 627609679, ; 91: Xamarin.AndroidX.CustomView => 0x2568904f => 219
	i32 627931235, ; 92: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 297
	i32 639843206, ; 93: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 225
	i32 643868501, ; 94: System.Net => 0x2660a755 => 80
	i32 662205335, ; 95: System.Text.Encodings.Web.dll => 0x27787397 => 135
	i32 663517072, ; 96: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 261
	i32 666292255, ; 97: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 206
	i32 672442732, ; 98: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 99: System.Net.Security => 0x28bdabca => 72
	i32 690569205, ; 100: System.Xml.Linq.dll => 0x29293ff5 => 154
	i32 691348768, ; 101: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 276
	i32 693804605, ; 102: System.Windows => 0x295a9e3d => 153
	i32 699345723, ; 103: System.Reflection.Emit => 0x29af2b3b => 91
	i32 700284507, ; 104: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 271
	i32 700358131, ; 105: System.IO.Compression.ZipFile => 0x29be9df3 => 44
	i32 720511267, ; 106: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 275
	i32 722857257, ; 107: System.Runtime.Loader.dll => 0x2b15ed29 => 108
	i32 731701662, ; 108: Microsoft.Extensions.Options.ConfigurationExtensions => 0x2b9ce19e => 186
	i32 735137430, ; 109: System.Security.SecureString.dll => 0x2bd14e96 => 128
	i32 752232764, ; 110: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 111: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 196
	i32 759454413, ; 112: System.Net.Requests => 0x2d445acd => 71
	i32 762598435, ; 113: System.IO.Pipes.dll => 0x2d745423 => 54
	i32 775507847, ; 114: System.IO.Compression => 0x2e394f87 => 45
	i32 777317022, ; 115: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 303
	i32 789151979, ; 116: Microsoft.Extensions.Options => 0x2f0980eb => 185
	i32 790371945, ; 117: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 220
	i32 804715423, ; 118: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 119: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 234
	i32 823281589, ; 120: System.Private.Uri.dll => 0x311247b5 => 85
	i32 830298997, ; 121: System.IO.Compression.Brotli => 0x317d5b75 => 42
	i32 832635846, ; 122: System.Xml.XPath.dll => 0x31a103c6 => 159
	i32 834051424, ; 123: System.Net.Quic => 0x31b69d60 => 70
	i32 843511501, ; 124: Xamarin.AndroidX.Print => 0x3246f6cd => 247
	i32 869139383, ; 125: hi\Microsoft.Maui.Controls.resources.dll => 0x33ce03b7 => 288
	i32 873119928, ; 126: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 127: System.Globalization.dll => 0x34505120 => 41
	i32 878954865, ; 128: System.Net.Http.Json => 0x3463c971 => 62
	i32 880668424, ; 129: ru\Microsoft.Maui.Controls.resources.dll => 0x347def08 => 302
	i32 904024072, ; 130: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 131: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 52
	i32 918734561, ; 132: pt-BR\Microsoft.Maui.Controls.resources.dll => 0x36c2c6e1 => 299
	i32 928116545, ; 133: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 270
	i32 952186615, ; 134: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 104
	i32 956575887, ; 135: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 275
	i32 961460050, ; 136: it\Microsoft.Maui.Controls.resources.dll => 0x394eb752 => 292
	i32 966729478, ; 137: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 268
	i32 967690846, ; 138: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 231
	i32 975236339, ; 139: System.Diagnostics.Tracing => 0x3a20ecf3 => 33
	i32 975874589, ; 140: System.Xml.XDocument => 0x3a2aaa1d => 157
	i32 986514023, ; 141: System.Private.DataContractSerialization.dll => 0x3acd0267 => 84
	i32 987214855, ; 142: System.Diagnostics.Tools => 0x3ad7b407 => 31
	i32 990727110, ; 143: ro\Microsoft.Maui.Controls.resources.dll => 0x3b0d4bc6 => 301
	i32 992768348, ; 144: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 145: System.IO.FileSystem => 0x3b45fb35 => 50
	i32 1001831731, ; 146: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 55
	i32 1012816738, ; 147: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 251
	i32 1019214401, ; 148: System.Drawing => 0x3cbffa41 => 35
	i32 1028951442, ; 149: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 178
	i32 1031528504, ; 150: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 269
	i32 1035644815, ; 151: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 204
	i32 1036536393, ; 152: System.Drawing.Primitives.dll => 0x3dc84a49 => 34
	i32 1043950537, ; 153: de\Microsoft.Maui.Controls.resources.dll => 0x3e396bc9 => 282
	i32 1044663988, ; 154: System.Linq.Expressions.dll => 0x3e444eb4 => 57
	i32 1048992957, ; 155: Microsoft.Extensions.Diagnostics.Abstractions.dll => 0x3e865cbd => 180
	i32 1052210849, ; 156: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 238
	i32 1067306892, ; 157: GoogleGson => 0x3f9dcf8c => 173
	i32 1082857460, ; 158: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 159: Xamarin.Kotlin.StdLib => 0x409e66d8 => 272
	i32 1098259244, ; 160: System => 0x41761b2c => 163
	i32 1108272742, ; 161: sv\Microsoft.Maui.Controls.resources.dll => 0x420ee666 => 304
	i32 1117529484, ; 162: pl\Microsoft.Maui.Controls.resources.dll => 0x429c258c => 298
	i32 1118262833, ; 163: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 294
	i32 1121599056, ; 164: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 237
	i32 1127624469, ; 165: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 184
	i32 1149092582, ; 166: Xamarin.AndroidX.Window => 0x447dc2e6 => 264
	i32 1168523401, ; 167: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 300
	i32 1170634674, ; 168: System.Web.dll => 0x45c677b2 => 152
	i32 1175144683, ; 169: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 260
	i32 1178241025, ; 170: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 245
	i32 1204270330, ; 171: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 206
	i32 1208641965, ; 172: System.Diagnostics.Process => 0x480a69ad => 28
	i32 1214827643, ; 173: CommunityToolkit.Mvvm => 0x4868cc7b => 172
	i32 1219128291, ; 174: System.IO.IsolatedStorage => 0x48aa6be3 => 51
	i32 1243150071, ; 175: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 265
	i32 1253011324, ; 176: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 177: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 280
	i32 1264511973, ; 178: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 255
	i32 1267360935, ; 179: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 259
	i32 1273260888, ; 180: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 211
	i32 1275534314, ; 181: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 276
	i32 1278448581, ; 182: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 203
	i32 1293217323, ; 183: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 222
	i32 1308624726, ; 184: hr\Microsoft.Maui.Controls.resources.dll => 0x4e000756 => 289
	i32 1309188875, ; 185: System.Private.DataContractSerialization => 0x4e08a30b => 84
	i32 1322716291, ; 186: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 264
	i32 1324164729, ; 187: System.Linq => 0x4eed2679 => 60
	i32 1335329327, ; 188: System.Runtime.Serialization.Json.dll => 0x4f97822f => 111
	i32 1336711579, ; 189: zh-HK\Microsoft.Maui.Controls.resources.dll => 0x4fac999b => 309
	i32 1364015309, ; 190: System.IO => 0x514d38cd => 56
	i32 1373134921, ; 191: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 310
	i32 1376866003, ; 192: Xamarin.AndroidX.SavedState => 0x52114ed3 => 251
	i32 1379779777, ; 193: System.Resources.ResourceManager => 0x523dc4c1 => 98
	i32 1402170036, ; 194: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 195: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 215
	i32 1408764838, ; 196: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 110
	i32 1411638395, ; 197: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 100
	i32 1422545099, ; 198: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 101
	i32 1430672901, ; 199: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 278
	i32 1434145427, ; 200: System.Runtime.Handles => 0x557b5293 => 103
	i32 1435222561, ; 201: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 268
	i32 1439761251, ; 202: System.Net.Quic.dll => 0x55d10363 => 70
	i32 1452070440, ; 203: System.Formats.Asn1.dll => 0x568cd628 => 37
	i32 1453312822, ; 204: System.Diagnostics.Tools.dll => 0x569fcb36 => 31
	i32 1457743152, ; 205: System.Runtime.Extensions.dll => 0x56e36530 => 102
	i32 1458022317, ; 206: System.Net.Security.dll => 0x56e7a7ad => 72
	i32 1461004990, ; 207: es\Microsoft.Maui.Controls.resources => 0x57152abe => 284
	i32 1461234159, ; 208: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 209: System.Security.Cryptography.OpenSsl => 0x57201017 => 122
	i32 1462112819, ; 210: System.IO.Compression.dll => 0x57261233 => 45
	i32 1469204771, ; 211: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 205
	i32 1470490898, ; 212: Microsoft.Extensions.Primitives => 0x57a5e912 => 187
	i32 1479771757, ; 213: System.Collections.Immutable => 0x5833866d => 9
	i32 1480492111, ; 214: System.IO.Compression.Brotli.dll => 0x583e844f => 42
	i32 1487239319, ; 215: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 216: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 252
	i32 1505131794, ; 217: Microsoft.Extensions.Http => 0x59b67d12 => 181
	i32 1526286932, ; 218: vi\Microsoft.Maui.Controls.resources.dll => 0x5af94a54 => 308
	i32 1536373174, ; 219: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 30
	i32 1543031311, ; 220: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 137
	i32 1543355203, ; 221: System.Reflection.Emit.dll => 0x5bfdbb43 => 91
	i32 1550322496, ; 222: System.Reflection.Extensions.dll => 0x5c680b40 => 92
	i32 1565862583, ; 223: System.IO.FileSystem.Primitives => 0x5d552ab7 => 48
	i32 1566207040, ; 224: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 140
	i32 1573704789, ; 225: System.Runtime.Serialization.Json => 0x5dccd455 => 111
	i32 1580037396, ; 226: System.Threading.Overlapped => 0x5e2d7514 => 139
	i32 1582372066, ; 227: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 221
	i32 1592978981, ; 228: System.Runtime.Serialization.dll => 0x5ef2ee25 => 114
	i32 1597949149, ; 229: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 269
	i32 1601112923, ; 230: System.Xml.Serialization => 0x5f6f0b5b => 156
	i32 1604827217, ; 231: System.Net.WebClient => 0x5fa7b851 => 75
	i32 1618516317, ; 232: System.Net.WebSockets.Client.dll => 0x6078995d => 78
	i32 1622152042, ; 233: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 241
	i32 1622358360, ; 234: System.Dynamic.Runtime => 0x60b33958 => 36
	i32 1624863272, ; 235: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 263
	i32 1635184631, ; 236: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 225
	i32 1636350590, ; 237: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 218
	i32 1639515021, ; 238: System.Net.Http.dll => 0x61b9038d => 63
	i32 1639986890, ; 239: System.Text.RegularExpressions => 0x61c036ca => 137
	i32 1641389582, ; 240: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 241: System.Runtime => 0x62c6282e => 115
	i32 1658241508, ; 242: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 257
	i32 1658251792, ; 243: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 266
	i32 1670060433, ; 244: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 213
	i32 1675553242, ; 245: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 47
	i32 1677501392, ; 246: System.Net.Primitives.dll => 0x63fca3d0 => 69
	i32 1678508291, ; 247: System.Net.WebSockets => 0x640c0103 => 79
	i32 1679769178, ; 248: System.Security.Cryptography => 0x641f3e5a => 125
	i32 1691477237, ; 249: System.Reflection.Metadata => 0x64d1e4f5 => 93
	i32 1696967625, ; 250: System.Security.Cryptography.Csp => 0x6525abc9 => 120
	i32 1698840827, ; 251: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 273
	i32 1701541528, ; 252: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 253: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 234
	i32 1726116996, ; 254: System.Reflection.dll => 0x66e27484 => 96
	i32 1728033016, ; 255: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 27
	i32 1729485958, ; 256: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 209
	i32 1743415430, ; 257: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 279
	i32 1744735666, ; 258: System.Transactions.Local.dll => 0x67fe8db2 => 148
	i32 1746316138, ; 259: Mono.Android.Export => 0x6816ab6a => 168
	i32 1750313021, ; 260: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 261: System.Resources.Reader.dll => 0x68cc9d1e => 97
	i32 1763938596, ; 262: System.Diagnostics.TraceSource.dll => 0x69239124 => 32
	i32 1765942094, ; 263: System.Reflection.Extensions => 0x6942234e => 92
	i32 1766324549, ; 264: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 256
	i32 1770582343, ; 265: Microsoft.Extensions.Logging.dll => 0x6988f147 => 182
	i32 1776026572, ; 266: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 267: System.Globalization.Extensions.dll => 0x69ec0683 => 40
	i32 1780572499, ; 268: Mono.Android.Runtime.dll => 0x6a216153 => 169
	i32 1782862114, ; 269: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 295
	i32 1788241197, ; 270: Xamarin.AndroidX.Fragment => 0x6a96652d => 227
	i32 1793755602, ; 271: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 287
	i32 1808609942, ; 272: Xamarin.AndroidX.Loader => 0x6bcd3296 => 241
	i32 1813058853, ; 273: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 272
	i32 1813201214, ; 274: Xamarin.Google.Android.Material => 0x6c13413e => 266
	i32 1818569960, ; 275: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 246
	i32 1818787751, ; 276: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 277: System.Text.Encoding.Extensions => 0x6cbab720 => 133
	i32 1824722060, ; 278: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 110
	i32 1828688058, ; 279: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 183
	i32 1847515442, ; 280: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 196
	i32 1853025655, ; 281: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 304
	i32 1858542181, ; 282: System.Linq.Expressions => 0x6ec71a65 => 57
	i32 1870277092, ; 283: System.Reflection.Primitives => 0x6f7a29e4 => 94
	i32 1875935024, ; 284: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 286
	i32 1879696579, ; 285: System.Formats.Tar.dll => 0x7009e4c3 => 38
	i32 1885316902, ; 286: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 207
	i32 1888955245, ; 287: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 288: System.Reflection.Metadata.dll => 0x70a66bdd => 93
	i32 1893218855, ; 289: cs\Microsoft.Maui.Controls.resources.dll => 0x70d83a27 => 280
	i32 1898237753, ; 290: System.Reflection.DispatchProxy => 0x7124cf39 => 88
	i32 1900610850, ; 291: System.Resources.ResourceManager.dll => 0x71490522 => 98
	i32 1910275211, ; 292: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1939592360, ; 293: System.Private.Xml.Linq => 0x739bd4a8 => 86
	i32 1953182387, ; 294: id\Microsoft.Maui.Controls.resources.dll => 0x746b32b3 => 291
	i32 1956758971, ; 295: System.Resources.Writer => 0x74a1c5bb => 99
	i32 1961813231, ; 296: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 253
	i32 1968388702, ; 297: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 174
	i32 1983156543, ; 298: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 273
	i32 1985761444, ; 299: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 198
	i32 2003115576, ; 300: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 283
	i32 2011961780, ; 301: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 302: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 238
	i32 2031763787, ; 303: Xamarin.Android.Glide => 0x791a414b => 195
	i32 2045470958, ; 304: System.Private.Xml => 0x79eb68ee => 87
	i32 2048278909, ; 305: Microsoft.Extensions.Configuration.Binder.dll => 0x7a16417d => 176
	i32 2055257422, ; 306: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 233
	i32 2060060697, ; 307: System.Windows.dll => 0x7aca0819 => 153
	i32 2066184531, ; 308: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 282
	i32 2070888862, ; 309: System.Diagnostics.TraceSource => 0x7b6f419e => 32
	i32 2079903147, ; 310: System.Runtime.dll => 0x7bf8cdab => 115
	i32 2090596640, ; 311: System.Numerics.Vectors => 0x7c9bf920 => 81
	i32 2127167465, ; 312: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 313: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 314: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 161
	i32 2146852085, ; 315: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 316: Microsoft.Maui => 0x80bd55ad => 191
	i32 2169148018, ; 317: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 290
	i32 2181898931, ; 318: Microsoft.Extensions.Options.dll => 0x820d22b3 => 185
	i32 2192057212, ; 319: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 183
	i32 2193016926, ; 320: System.ObjectModel.dll => 0x82b6c85e => 83
	i32 2201107256, ; 321: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 277
	i32 2201231467, ; 322: System.Net.Http => 0x8334206b => 63
	i32 2207618523, ; 323: it\Microsoft.Maui.Controls.resources => 0x839595db => 292
	i32 2217644978, ; 324: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 260
	i32 2222056684, ; 325: System.Threading.Tasks.Parallel => 0x8471e4ec => 142
	i32 2244775296, ; 326: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 242
	i32 2252106437, ; 327: System.Xml.Serialization.dll => 0x863c6ac5 => 156
	i32 2256313426, ; 328: System.Globalization.Extensions => 0x867c9c52 => 40
	i32 2265110946, ; 329: System.Security.AccessControl.dll => 0x8702d9a2 => 116
	i32 2266799131, ; 330: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 175
	i32 2267999099, ; 331: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 197
	i32 2279755925, ; 332: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 249
	i32 2293034957, ; 333: System.ServiceModel.Web.dll => 0x88acefcd => 130
	i32 2295906218, ; 334: System.Net.Sockets => 0x88d8bfaa => 74
	i32 2298471582, ; 335: System.Net.Mail => 0x88ffe49e => 65
	i32 2303942373, ; 336: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 296
	i32 2305521784, ; 337: System.Private.CoreLib.dll => 0x896b7878 => 171
	i32 2315684594, ; 338: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 201
	i32 2320631194, ; 339: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 142
	i32 2340441535, ; 340: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 105
	i32 2344264397, ; 341: System.ValueTuple => 0x8bbaa2cd => 150
	i32 2353062107, ; 342: System.Net.Primitives => 0x8c40e0db => 69
	i32 2366048013, ; 343: hu\Microsoft.Maui.Controls.resources.dll => 0x8d07070d => 290
	i32 2368005991, ; 344: System.Xml.ReaderWriter.dll => 0x8d24e767 => 155
	i32 2371007202, ; 345: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 174
	i32 2378619854, ; 346: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 120
	i32 2383496789, ; 347: System.Security.Principal.Windows.dll => 0x8e114655 => 126
	i32 2395872292, ; 348: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 291
	i32 2401565422, ; 349: System.Web.HttpUtility => 0x8f24faee => 151
	i32 2403452196, ; 350: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 224
	i32 2421380589, ; 351: System.Threading.Tasks.Dataflow => 0x905355ed => 140
	i32 2423080555, ; 352: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 211
	i32 2427813419, ; 353: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 288
	i32 2435356389, ; 354: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 355: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2454642406, ; 356: System.Text.Encoding.dll => 0x924edee6 => 134
	i32 2458678730, ; 357: System.Net.Sockets.dll => 0x928c75ca => 74
	i32 2459001652, ; 358: System.Linq.Parallel.dll => 0x92916334 => 58
	i32 2465532216, ; 359: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 214
	i32 2471841756, ; 360: netstandard.dll => 0x93554fdc => 166
	i32 2475788418, ; 361: Java.Interop.dll => 0x93918882 => 167
	i32 2480646305, ; 362: Microsoft.Maui.Controls => 0x93dba8a1 => 189
	i32 2483903535, ; 363: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 364: System.Net.ServicePoint => 0x94147f61 => 73
	i32 2490993605, ; 365: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 366: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2503351294, ; 367: ko\Microsoft.Maui.Controls.resources.dll => 0x95361bfe => 294
	i32 2505896520, ; 368: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 236
	i32 2522472828, ; 369: Xamarin.Android.Glide.dll => 0x9659e17c => 195
	i32 2538310050, ; 370: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 90
	i32 2550873716, ; 371: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 289
	i32 2562349572, ; 372: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 373: System.Text.Encodings.Web => 0x9930ee42 => 135
	i32 2576534780, ; 374: ja\Microsoft.Maui.Controls.resources.dll => 0x9992ccfc => 293
	i32 2581783588, ; 375: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 237
	i32 2581819634, ; 376: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 259
	i32 2585220780, ; 377: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 133
	i32 2585805581, ; 378: System.Net.Ping => 0x9a20430d => 68
	i32 2589602615, ; 379: System.Threading.ThreadPool => 0x9a5a3337 => 145
	i32 2593496499, ; 380: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 298
	i32 2605712449, ; 381: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 277
	i32 2615233544, ; 382: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 228
	i32 2616218305, ; 383: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 184
	i32 2617129537, ; 384: System.Private.Xml.dll => 0x9bfe3a41 => 87
	i32 2618712057, ; 385: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 95
	i32 2620871830, ; 386: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 218
	i32 2624644809, ; 387: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 223
	i32 2626831493, ; 388: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 293
	i32 2627185994, ; 389: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 30
	i32 2629843544, ; 390: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 44
	i32 2633051222, ; 391: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 232
	i32 2663391936, ; 392: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 197
	i32 2663698177, ; 393: System.Runtime.Loader => 0x9ec4cf01 => 108
	i32 2664396074, ; 394: System.Xml.XDocument.dll => 0x9ecf752a => 157
	i32 2665622720, ; 395: System.Drawing.Primitives => 0x9ee22cc0 => 34
	i32 2676780864, ; 396: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 397: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 113
	i32 2693849962, ; 398: System.IO.dll => 0xa090e36a => 56
	i32 2701096212, ; 399: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 257
	i32 2715334215, ; 400: System.Threading.Tasks.dll => 0xa1d8b647 => 143
	i32 2717744543, ; 401: System.Security.Claims => 0xa1fd7d9f => 117
	i32 2719963679, ; 402: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 119
	i32 2724373263, ; 403: System.Runtime.Numerics.dll => 0xa262a30f => 109
	i32 2732626843, ; 404: Xamarin.AndroidX.Activity => 0xa2e0939b => 199
	i32 2735172069, ; 405: System.Threading.Channels => 0xa30769e5 => 138
	i32 2737747696, ; 406: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 205
	i32 2740698338, ; 407: ca\Microsoft.Maui.Controls.resources.dll => 0xa35bbce2 => 279
	i32 2740948882, ; 408: System.IO.Pipes.AccessControl => 0xa35f8f92 => 53
	i32 2748088231, ; 409: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 104
	i32 2752995522, ; 410: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 299
	i32 2758225723, ; 411: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 190
	i32 2764765095, ; 412: Microsoft.Maui.dll => 0xa4caf7a7 => 191
	i32 2765824710, ; 413: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 132
	i32 2770495804, ; 414: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 271
	i32 2778768386, ; 415: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 262
	i32 2779977773, ; 416: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 250
	i32 2785988530, ; 417: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 305
	i32 2788224221, ; 418: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 228
	i32 2801831435, ; 419: Microsoft.Maui.Graphics => 0xa7008e0b => 193
	i32 2803228030, ; 420: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 158
	i32 2810250172, ; 421: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 215
	i32 2819470561, ; 422: System.Xml.dll => 0xa80db4e1 => 162
	i32 2821205001, ; 423: System.ServiceProcess.dll => 0xa8282c09 => 131
	i32 2821294376, ; 424: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 250
	i32 2824502124, ; 425: System.Xml.XmlDocument => 0xa85a7b6c => 160
	i32 2838993487, ; 426: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 239
	i32 2849599387, ; 427: System.Threading.Overlapped.dll => 0xa9d96f9b => 139
	i32 2853208004, ; 428: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 262
	i32 2855708567, ; 429: Xamarin.AndroidX.Transition => 0xaa36a797 => 258
	i32 2861098320, ; 430: Mono.Android.Export.dll => 0xaa88e550 => 168
	i32 2861189240, ; 431: Microsoft.Maui.Essentials => 0xaa8a4878 => 192
	i32 2870099610, ; 432: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 200
	i32 2875164099, ; 433: Jsr305Binding.dll => 0xab5f85c3 => 267
	i32 2875220617, ; 434: System.Globalization.Calendars.dll => 0xab606289 => 39
	i32 2884993177, ; 435: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 226
	i32 2887636118, ; 436: System.Net.dll => 0xac1dd496 => 80
	i32 2899753641, ; 437: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 55
	i32 2900621748, ; 438: System.Dynamic.Runtime.dll => 0xace3f9b4 => 36
	i32 2901442782, ; 439: System.Reflection => 0xacf080de => 96
	i32 2905242038, ; 440: mscorlib.dll => 0xad2a79b6 => 165
	i32 2909740682, ; 441: System.Private.CoreLib => 0xad6f1e8a => 171
	i32 2916838712, ; 442: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 263
	i32 2919462931, ; 443: System.Numerics.Vectors.dll => 0xae037813 => 81
	i32 2921128767, ; 444: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 202
	i32 2936416060, ; 445: System.Resources.Reader => 0xaf06273c => 97
	i32 2940926066, ; 446: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 29
	i32 2942453041, ; 447: System.Xml.XPath.XDocument => 0xaf624531 => 158
	i32 2959614098, ; 448: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2968338931, ; 449: System.Security.Principal.Windows => 0xb0ed41f3 => 126
	i32 2971004615, ; 450: Microsoft.Extensions.Options.ConfigurationExtensions.dll => 0xb115eec7 => 186
	i32 2972252294, ; 451: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 118
	i32 2978675010, ; 452: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 222
	i32 2987532451, ; 453: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 253
	i32 2996846495, ; 454: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 235
	i32 3016983068, ; 455: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 255
	i32 3020703001, ; 456: Microsoft.Extensions.Diagnostics => 0xb40c4519 => 179
	i32 3023353419, ; 457: WindowsBase.dll => 0xb434b64b => 164
	i32 3024354802, ; 458: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 230
	i32 3038032645, ; 459: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 312
	i32 3053864966, ; 460: fi\Microsoft.Maui.Controls.resources.dll => 0xb6064806 => 285
	i32 3056245963, ; 461: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 252
	i32 3057625584, ; 462: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 243
	i32 3059408633, ; 463: Mono.Android.Runtime => 0xb65adef9 => 169
	i32 3059793426, ; 464: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 465: System.Threading.Tasks => 0xb755818f => 143
	i32 3090735792, ; 466: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 124
	i32 3099732863, ; 467: System.Security.Claims.dll => 0xb8c22b7f => 117
	i32 3103600923, ; 468: System.Formats.Asn1 => 0xb8fd311b => 37
	i32 3111772706, ; 469: System.Runtime.Serialization => 0xb979e222 => 114
	i32 3121463068, ; 470: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 46
	i32 3124832203, ; 471: System.Threading.Tasks.Extensions => 0xba4127cb => 141
	i32 3132293585, ; 472: System.Security.AccessControl => 0xbab301d1 => 116
	i32 3147165239, ; 473: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 33
	i32 3148237826, ; 474: GoogleGson.dll => 0xbba64c02 => 173
	i32 3159123045, ; 475: System.Reflection.Primitives.dll => 0xbc4c6465 => 94
	i32 3160747431, ; 476: System.IO.MemoryMappedFiles => 0xbc652da7 => 52
	i32 3178803400, ; 477: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 244
	i32 3192346100, ; 478: System.Security.SecureString => 0xbe4755f4 => 128
	i32 3193515020, ; 479: System.Web => 0xbe592c0c => 152
	i32 3204380047, ; 480: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 481: System.Xml.XmlDocument.dll => 0xbf506931 => 160
	i32 3211777861, ; 482: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 221
	i32 3220365878, ; 483: System.Threading => 0xbff2e236 => 147
	i32 3226221578, ; 484: System.Runtime.Handles.dll => 0xc04c3c0a => 103
	i32 3251039220, ; 485: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 88
	i32 3258312781, ; 486: Xamarin.AndroidX.CardView => 0xc235e84d => 209
	i32 3265493905, ; 487: System.Linq.Queryable.dll => 0xc2a37b91 => 59
	i32 3265893370, ; 488: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 141
	i32 3277815716, ; 489: System.Resources.Writer.dll => 0xc35f7fa4 => 99
	i32 3279906254, ; 490: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 491: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 492: System.Security.Cryptography.Encoding => 0xc4251ff9 => 121
	i32 3299363146, ; 493: System.Text.Encoding => 0xc4a8494a => 134
	i32 3303498502, ; 494: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 27
	i32 3305363605, ; 495: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 285
	i32 3316684772, ; 496: System.Net.Requests.dll => 0xc5b097e4 => 71
	i32 3317135071, ; 497: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 219
	i32 3317144872, ; 498: System.Data => 0xc5b79d28 => 24
	i32 3340431453, ; 499: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 207
	i32 3345895724, ; 500: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 248
	i32 3346324047, ; 501: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 245
	i32 3357674450, ; 502: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 302
	i32 3358260929, ; 503: System.Text.Json => 0xc82afec1 => 136
	i32 3362336904, ; 504: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 200
	i32 3362522851, ; 505: Xamarin.AndroidX.Core => 0xc86c06e3 => 216
	i32 3366347497, ; 506: Java.Interop => 0xc8a662e9 => 167
	i32 3374999561, ; 507: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 249
	i32 3381016424, ; 508: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 281
	i32 3395150330, ; 509: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 100
	i32 3403906625, ; 510: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 122
	i32 3405233483, ; 511: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 220
	i32 3421170118, ; 512: Microsoft.Extensions.Configuration.Binder => 0xcbeae9c6 => 176
	i32 3428513518, ; 513: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 177
	i32 3429136800, ; 514: System.Xml => 0xcc6479a0 => 162
	i32 3430777524, ; 515: netstandard => 0xcc7d82b4 => 166
	i32 3441283291, ; 516: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 223
	i32 3445260447, ; 517: System.Formats.Tar => 0xcd5a809f => 38
	i32 3452344032, ; 518: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 188
	i32 3458724246, ; 519: pt\Microsoft.Maui.Controls.resources.dll => 0xce27f196 => 300
	i32 3471940407, ; 520: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3476120550, ; 521: Mono.Android => 0xcf3163e6 => 170
	i32 3484440000, ; 522: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 301
	i32 3485117614, ; 523: System.Text.Json.dll => 0xcfbaacae => 136
	i32 3486566296, ; 524: System.Transactions => 0xcfd0c798 => 149
	i32 3493954962, ; 525: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 212
	i32 3509114376, ; 526: System.Xml.Linq => 0xd128d608 => 154
	i32 3515174580, ; 527: System.Security.dll => 0xd1854eb4 => 129
	i32 3530912306, ; 528: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 529: System.Net.HttpListener => 0xd2ff69f1 => 64
	i32 3560100363, ; 530: System.Threading.Timer => 0xd432d20b => 146
	i32 3570554715, ; 531: System.IO.FileSystem.AccessControl => 0xd4d2575b => 46
	i32 3580758918, ; 532: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 309
	i32 3592228221, ; 533: zh-Hant\Microsoft.Maui.Controls.resources.dll => 0xd61d0d7d => 311
	i32 3597029428, ; 534: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 198
	i32 3598340787, ; 535: System.Net.WebSockets.Client => 0xd67a52b3 => 78
	i32 3608519521, ; 536: System.Linq.dll => 0xd715a361 => 60
	i32 3624195450, ; 537: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 105
	i32 3627220390, ; 538: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 247
	i32 3633644679, ; 539: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 202
	i32 3638274909, ; 540: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 48
	i32 3641597786, ; 541: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 233
	i32 3643446276, ; 542: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 306
	i32 3643854240, ; 543: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 244
	i32 3645089577, ; 544: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 545: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 175
	i32 3660523487, ; 546: System.Net.NetworkInformation => 0xda2f27df => 67
	i32 3672681054, ; 547: Mono.Android.dll => 0xdae8aa5e => 170
	i32 3682565725, ; 548: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 208
	i32 3684561358, ; 549: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 212
	i32 3700866549, ; 550: System.Net.WebProxy.dll => 0xdc96bdf5 => 77
	i32 3706696989, ; 551: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 217
	i32 3716563718, ; 552: System.Runtime.Intrinsics => 0xdd864306 => 107
	i32 3718780102, ; 553: Xamarin.AndroidX.Annotation => 0xdda814c6 => 201
	i32 3724971120, ; 554: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 243
	i32 3732100267, ; 555: System.Net.NameResolution => 0xde7354ab => 66
	i32 3737834244, ; 556: System.Net.Http.Json.dll => 0xdecad304 => 62
	i32 3748608112, ; 557: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 194
	i32 3751444290, ; 558: System.Xml.XPath => 0xdf9a7f42 => 159
	i32 3751619990, ; 559: da\Microsoft.Maui.Controls.resources.dll => 0xdf9d2d96 => 281
	i32 3786282454, ; 560: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 210
	i32 3792276235, ; 561: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3800979733, ; 562: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 188
	i32 3802395368, ; 563: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3819260425, ; 564: System.Net.WebProxy => 0xe3a54a09 => 77
	i32 3823082795, ; 565: System.Security.Cryptography.dll => 0xe3df9d2b => 125
	i32 3829621856, ; 566: System.Numerics.dll => 0xe4436460 => 82
	i32 3841636137, ; 567: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 178
	i32 3844307129, ; 568: System.Net.Mail.dll => 0xe52378b9 => 65
	i32 3849253459, ; 569: System.Runtime.InteropServices.dll => 0xe56ef253 => 106
	i32 3870376305, ; 570: System.Net.HttpListener.dll => 0xe6b14171 => 64
	i32 3873536506, ; 571: System.Security.Principal => 0xe6e179fa => 127
	i32 3875112723, ; 572: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 121
	i32 3885497537, ; 573: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 76
	i32 3885922214, ; 574: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 258
	i32 3888767677, ; 575: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 248
	i32 3896106733, ; 576: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 577: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 216
	i32 3901907137, ; 578: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920221145, ; 579: nl\Microsoft.Maui.Controls.resources.dll => 0xe9a9d3d9 => 297
	i32 3920810846, ; 580: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 43
	i32 3921031405, ; 581: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 261
	i32 3928044579, ; 582: System.Xml.ReaderWriter => 0xea213423 => 155
	i32 3929004827, ; 583: GPTAndroid.dll => 0xea2fdb1b => 0
	i32 3930554604, ; 584: System.Security.Principal.dll => 0xea4780ec => 127
	i32 3931092270, ; 585: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 246
	i32 3945713374, ; 586: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 587: System.Text.Encoding.CodePages => 0xebac8bfe => 132
	i32 3955647286, ; 588: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 204
	i32 3959773229, ; 589: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 235
	i32 4003436829, ; 590: System.Diagnostics.Process.dll => 0xee9f991d => 28
	i32 4015948917, ; 591: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 203
	i32 4025784931, ; 592: System.Memory => 0xeff49a63 => 61
	i32 4046471985, ; 593: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 190
	i32 4054681211, ; 594: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 89
	i32 4068434129, ; 595: System.Private.Xml.Linq.dll => 0xf27f60d1 => 86
	i32 4073602200, ; 596: System.Threading.dll => 0xf2ce3c98 => 147
	i32 4091086043, ; 597: el\Microsoft.Maui.Controls.resources.dll => 0xf3d904db => 283
	i32 4094352644, ; 598: Microsoft.Maui.Essentials.dll => 0xf40add04 => 192
	i32 4099507663, ; 599: System.Drawing.dll => 0xf45985cf => 35
	i32 4100113165, ; 600: System.Private.Uri => 0xf462c30d => 85
	i32 4101593132, ; 601: Xamarin.AndroidX.Emoji2 => 0xf479582c => 224
	i32 4103439459, ; 602: uk\Microsoft.Maui.Controls.resources.dll => 0xf4958463 => 307
	i32 4126470640, ; 603: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 177
	i32 4127667938, ; 604: System.IO.FileSystem.Watcher => 0xf60736e2 => 49
	i32 4130442656, ; 605: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 606: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 89
	i32 4150914736, ; 607: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 307
	i32 4151237749, ; 608: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 609: System.Xml.XmlSerializer => 0xf7e95c85 => 161
	i32 4161255271, ; 610: System.Reflection.TypeExtensions => 0xf807b767 => 95
	i32 4164802419, ; 611: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 49
	i32 4181436372, ; 612: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 112
	i32 4182413190, ; 613: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 240
	i32 4185676441, ; 614: System.Security => 0xf97c5a99 => 129
	i32 4196529839, ; 615: System.Net.WebClient.dll => 0xfa21f6af => 75
	i32 4213026141, ; 616: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 194
	i32 4249188766, ; 617: nb\Microsoft.Maui.Controls.resources.dll => 0xfd45799e => 296
	i32 4256097574, ; 618: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 217
	i32 4258378803, ; 619: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 239
	i32 4260525087, ; 620: System.Buffers => 0xfdf2741f => 7
	i32 4271975918, ; 621: Microsoft.Maui.Controls.dll => 0xfea12dee => 189
	i32 4274623895, ; 622: CommunityToolkit.Mvvm.dll => 0xfec99597 => 172
	i32 4274976490, ; 623: System.Runtime.Numerics => 0xfecef6ea => 109
	i32 4292120959, ; 624: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 240
	i32 4294763496 ; 625: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 226
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [626 x i32] [
	i32 67, ; 0
	i32 66, ; 1
	i32 107, ; 2
	i32 236, ; 3
	i32 270, ; 4
	i32 47, ; 5
	i32 278, ; 6
	i32 79, ; 7
	i32 287, ; 8
	i32 144, ; 9
	i32 29, ; 10
	i32 311, ; 11
	i32 123, ; 12
	i32 193, ; 13
	i32 101, ; 14
	i32 295, ; 15
	i32 180, ; 16
	i32 254, ; 17
	i32 106, ; 18
	i32 254, ; 19
	i32 138, ; 20
	i32 274, ; 21
	i32 310, ; 22
	i32 303, ; 23
	i32 76, ; 24
	i32 123, ; 25
	i32 13, ; 26
	i32 210, ; 27
	i32 131, ; 28
	i32 256, ; 29
	i32 150, ; 30
	i32 18, ; 31
	i32 208, ; 32
	i32 26, ; 33
	i32 179, ; 34
	i32 230, ; 35
	i32 1, ; 36
	i32 58, ; 37
	i32 41, ; 38
	i32 90, ; 39
	i32 0, ; 40
	i32 213, ; 41
	i32 146, ; 42
	i32 232, ; 43
	i32 229, ; 44
	i32 53, ; 45
	i32 181, ; 46
	i32 68, ; 47
	i32 308, ; 48
	i32 199, ; 49
	i32 82, ; 50
	i32 286, ; 51
	i32 231, ; 52
	i32 130, ; 53
	i32 54, ; 54
	i32 148, ; 55
	i32 73, ; 56
	i32 144, ; 57
	i32 61, ; 58
	i32 145, ; 59
	i32 312, ; 60
	i32 164, ; 61
	i32 306, ; 62
	i32 214, ; 63
	i32 12, ; 64
	i32 227, ; 65
	i32 124, ; 66
	i32 151, ; 67
	i32 112, ; 68
	i32 165, ; 69
	i32 163, ; 70
	i32 229, ; 71
	i32 242, ; 72
	i32 284, ; 73
	i32 83, ; 74
	i32 187, ; 75
	i32 149, ; 76
	i32 274, ; 77
	i32 59, ; 78
	i32 305, ; 79
	i32 182, ; 80
	i32 50, ; 81
	i32 102, ; 82
	i32 113, ; 83
	i32 39, ; 84
	i32 267, ; 85
	i32 265, ; 86
	i32 119, ; 87
	i32 51, ; 88
	i32 43, ; 89
	i32 118, ; 90
	i32 219, ; 91
	i32 297, ; 92
	i32 225, ; 93
	i32 80, ; 94
	i32 135, ; 95
	i32 261, ; 96
	i32 206, ; 97
	i32 8, ; 98
	i32 72, ; 99
	i32 154, ; 100
	i32 276, ; 101
	i32 153, ; 102
	i32 91, ; 103
	i32 271, ; 104
	i32 44, ; 105
	i32 275, ; 106
	i32 108, ; 107
	i32 186, ; 108
	i32 128, ; 109
	i32 25, ; 110
	i32 196, ; 111
	i32 71, ; 112
	i32 54, ; 113
	i32 45, ; 114
	i32 303, ; 115
	i32 185, ; 116
	i32 220, ; 117
	i32 22, ; 118
	i32 234, ; 119
	i32 85, ; 120
	i32 42, ; 121
	i32 159, ; 122
	i32 70, ; 123
	i32 247, ; 124
	i32 288, ; 125
	i32 3, ; 126
	i32 41, ; 127
	i32 62, ; 128
	i32 302, ; 129
	i32 16, ; 130
	i32 52, ; 131
	i32 299, ; 132
	i32 270, ; 133
	i32 104, ; 134
	i32 275, ; 135
	i32 292, ; 136
	i32 268, ; 137
	i32 231, ; 138
	i32 33, ; 139
	i32 157, ; 140
	i32 84, ; 141
	i32 31, ; 142
	i32 301, ; 143
	i32 12, ; 144
	i32 50, ; 145
	i32 55, ; 146
	i32 251, ; 147
	i32 35, ; 148
	i32 178, ; 149
	i32 269, ; 150
	i32 204, ; 151
	i32 34, ; 152
	i32 282, ; 153
	i32 57, ; 154
	i32 180, ; 155
	i32 238, ; 156
	i32 173, ; 157
	i32 17, ; 158
	i32 272, ; 159
	i32 163, ; 160
	i32 304, ; 161
	i32 298, ; 162
	i32 294, ; 163
	i32 237, ; 164
	i32 184, ; 165
	i32 264, ; 166
	i32 300, ; 167
	i32 152, ; 168
	i32 260, ; 169
	i32 245, ; 170
	i32 206, ; 171
	i32 28, ; 172
	i32 172, ; 173
	i32 51, ; 174
	i32 265, ; 175
	i32 5, ; 176
	i32 280, ; 177
	i32 255, ; 178
	i32 259, ; 179
	i32 211, ; 180
	i32 276, ; 181
	i32 203, ; 182
	i32 222, ; 183
	i32 289, ; 184
	i32 84, ; 185
	i32 264, ; 186
	i32 60, ; 187
	i32 111, ; 188
	i32 309, ; 189
	i32 56, ; 190
	i32 310, ; 191
	i32 251, ; 192
	i32 98, ; 193
	i32 19, ; 194
	i32 215, ; 195
	i32 110, ; 196
	i32 100, ; 197
	i32 101, ; 198
	i32 278, ; 199
	i32 103, ; 200
	i32 268, ; 201
	i32 70, ; 202
	i32 37, ; 203
	i32 31, ; 204
	i32 102, ; 205
	i32 72, ; 206
	i32 284, ; 207
	i32 9, ; 208
	i32 122, ; 209
	i32 45, ; 210
	i32 205, ; 211
	i32 187, ; 212
	i32 9, ; 213
	i32 42, ; 214
	i32 4, ; 215
	i32 252, ; 216
	i32 181, ; 217
	i32 308, ; 218
	i32 30, ; 219
	i32 137, ; 220
	i32 91, ; 221
	i32 92, ; 222
	i32 48, ; 223
	i32 140, ; 224
	i32 111, ; 225
	i32 139, ; 226
	i32 221, ; 227
	i32 114, ; 228
	i32 269, ; 229
	i32 156, ; 230
	i32 75, ; 231
	i32 78, ; 232
	i32 241, ; 233
	i32 36, ; 234
	i32 263, ; 235
	i32 225, ; 236
	i32 218, ; 237
	i32 63, ; 238
	i32 137, ; 239
	i32 15, ; 240
	i32 115, ; 241
	i32 257, ; 242
	i32 266, ; 243
	i32 213, ; 244
	i32 47, ; 245
	i32 69, ; 246
	i32 79, ; 247
	i32 125, ; 248
	i32 93, ; 249
	i32 120, ; 250
	i32 273, ; 251
	i32 26, ; 252
	i32 234, ; 253
	i32 96, ; 254
	i32 27, ; 255
	i32 209, ; 256
	i32 279, ; 257
	i32 148, ; 258
	i32 168, ; 259
	i32 4, ; 260
	i32 97, ; 261
	i32 32, ; 262
	i32 92, ; 263
	i32 256, ; 264
	i32 182, ; 265
	i32 21, ; 266
	i32 40, ; 267
	i32 169, ; 268
	i32 295, ; 269
	i32 227, ; 270
	i32 287, ; 271
	i32 241, ; 272
	i32 272, ; 273
	i32 266, ; 274
	i32 246, ; 275
	i32 2, ; 276
	i32 133, ; 277
	i32 110, ; 278
	i32 183, ; 279
	i32 196, ; 280
	i32 304, ; 281
	i32 57, ; 282
	i32 94, ; 283
	i32 286, ; 284
	i32 38, ; 285
	i32 207, ; 286
	i32 25, ; 287
	i32 93, ; 288
	i32 280, ; 289
	i32 88, ; 290
	i32 98, ; 291
	i32 10, ; 292
	i32 86, ; 293
	i32 291, ; 294
	i32 99, ; 295
	i32 253, ; 296
	i32 174, ; 297
	i32 273, ; 298
	i32 198, ; 299
	i32 283, ; 300
	i32 7, ; 301
	i32 238, ; 302
	i32 195, ; 303
	i32 87, ; 304
	i32 176, ; 305
	i32 233, ; 306
	i32 153, ; 307
	i32 282, ; 308
	i32 32, ; 309
	i32 115, ; 310
	i32 81, ; 311
	i32 20, ; 312
	i32 11, ; 313
	i32 161, ; 314
	i32 3, ; 315
	i32 191, ; 316
	i32 290, ; 317
	i32 185, ; 318
	i32 183, ; 319
	i32 83, ; 320
	i32 277, ; 321
	i32 63, ; 322
	i32 292, ; 323
	i32 260, ; 324
	i32 142, ; 325
	i32 242, ; 326
	i32 156, ; 327
	i32 40, ; 328
	i32 116, ; 329
	i32 175, ; 330
	i32 197, ; 331
	i32 249, ; 332
	i32 130, ; 333
	i32 74, ; 334
	i32 65, ; 335
	i32 296, ; 336
	i32 171, ; 337
	i32 201, ; 338
	i32 142, ; 339
	i32 105, ; 340
	i32 150, ; 341
	i32 69, ; 342
	i32 290, ; 343
	i32 155, ; 344
	i32 174, ; 345
	i32 120, ; 346
	i32 126, ; 347
	i32 291, ; 348
	i32 151, ; 349
	i32 224, ; 350
	i32 140, ; 351
	i32 211, ; 352
	i32 288, ; 353
	i32 20, ; 354
	i32 14, ; 355
	i32 134, ; 356
	i32 74, ; 357
	i32 58, ; 358
	i32 214, ; 359
	i32 166, ; 360
	i32 167, ; 361
	i32 189, ; 362
	i32 15, ; 363
	i32 73, ; 364
	i32 6, ; 365
	i32 23, ; 366
	i32 294, ; 367
	i32 236, ; 368
	i32 195, ; 369
	i32 90, ; 370
	i32 289, ; 371
	i32 1, ; 372
	i32 135, ; 373
	i32 293, ; 374
	i32 237, ; 375
	i32 259, ; 376
	i32 133, ; 377
	i32 68, ; 378
	i32 145, ; 379
	i32 298, ; 380
	i32 277, ; 381
	i32 228, ; 382
	i32 184, ; 383
	i32 87, ; 384
	i32 95, ; 385
	i32 218, ; 386
	i32 223, ; 387
	i32 293, ; 388
	i32 30, ; 389
	i32 44, ; 390
	i32 232, ; 391
	i32 197, ; 392
	i32 108, ; 393
	i32 157, ; 394
	i32 34, ; 395
	i32 22, ; 396
	i32 113, ; 397
	i32 56, ; 398
	i32 257, ; 399
	i32 143, ; 400
	i32 117, ; 401
	i32 119, ; 402
	i32 109, ; 403
	i32 199, ; 404
	i32 138, ; 405
	i32 205, ; 406
	i32 279, ; 407
	i32 53, ; 408
	i32 104, ; 409
	i32 299, ; 410
	i32 190, ; 411
	i32 191, ; 412
	i32 132, ; 413
	i32 271, ; 414
	i32 262, ; 415
	i32 250, ; 416
	i32 305, ; 417
	i32 228, ; 418
	i32 193, ; 419
	i32 158, ; 420
	i32 215, ; 421
	i32 162, ; 422
	i32 131, ; 423
	i32 250, ; 424
	i32 160, ; 425
	i32 239, ; 426
	i32 139, ; 427
	i32 262, ; 428
	i32 258, ; 429
	i32 168, ; 430
	i32 192, ; 431
	i32 200, ; 432
	i32 267, ; 433
	i32 39, ; 434
	i32 226, ; 435
	i32 80, ; 436
	i32 55, ; 437
	i32 36, ; 438
	i32 96, ; 439
	i32 165, ; 440
	i32 171, ; 441
	i32 263, ; 442
	i32 81, ; 443
	i32 202, ; 444
	i32 97, ; 445
	i32 29, ; 446
	i32 158, ; 447
	i32 18, ; 448
	i32 126, ; 449
	i32 186, ; 450
	i32 118, ; 451
	i32 222, ; 452
	i32 253, ; 453
	i32 235, ; 454
	i32 255, ; 455
	i32 179, ; 456
	i32 164, ; 457
	i32 230, ; 458
	i32 312, ; 459
	i32 285, ; 460
	i32 252, ; 461
	i32 243, ; 462
	i32 169, ; 463
	i32 16, ; 464
	i32 143, ; 465
	i32 124, ; 466
	i32 117, ; 467
	i32 37, ; 468
	i32 114, ; 469
	i32 46, ; 470
	i32 141, ; 471
	i32 116, ; 472
	i32 33, ; 473
	i32 173, ; 474
	i32 94, ; 475
	i32 52, ; 476
	i32 244, ; 477
	i32 128, ; 478
	i32 152, ; 479
	i32 24, ; 480
	i32 160, ; 481
	i32 221, ; 482
	i32 147, ; 483
	i32 103, ; 484
	i32 88, ; 485
	i32 209, ; 486
	i32 59, ; 487
	i32 141, ; 488
	i32 99, ; 489
	i32 5, ; 490
	i32 13, ; 491
	i32 121, ; 492
	i32 134, ; 493
	i32 27, ; 494
	i32 285, ; 495
	i32 71, ; 496
	i32 219, ; 497
	i32 24, ; 498
	i32 207, ; 499
	i32 248, ; 500
	i32 245, ; 501
	i32 302, ; 502
	i32 136, ; 503
	i32 200, ; 504
	i32 216, ; 505
	i32 167, ; 506
	i32 249, ; 507
	i32 281, ; 508
	i32 100, ; 509
	i32 122, ; 510
	i32 220, ; 511
	i32 176, ; 512
	i32 177, ; 513
	i32 162, ; 514
	i32 166, ; 515
	i32 223, ; 516
	i32 38, ; 517
	i32 188, ; 518
	i32 300, ; 519
	i32 17, ; 520
	i32 170, ; 521
	i32 301, ; 522
	i32 136, ; 523
	i32 149, ; 524
	i32 212, ; 525
	i32 154, ; 526
	i32 129, ; 527
	i32 19, ; 528
	i32 64, ; 529
	i32 146, ; 530
	i32 46, ; 531
	i32 309, ; 532
	i32 311, ; 533
	i32 198, ; 534
	i32 78, ; 535
	i32 60, ; 536
	i32 105, ; 537
	i32 247, ; 538
	i32 202, ; 539
	i32 48, ; 540
	i32 233, ; 541
	i32 306, ; 542
	i32 244, ; 543
	i32 14, ; 544
	i32 175, ; 545
	i32 67, ; 546
	i32 170, ; 547
	i32 208, ; 548
	i32 212, ; 549
	i32 77, ; 550
	i32 217, ; 551
	i32 107, ; 552
	i32 201, ; 553
	i32 243, ; 554
	i32 66, ; 555
	i32 62, ; 556
	i32 194, ; 557
	i32 159, ; 558
	i32 281, ; 559
	i32 210, ; 560
	i32 10, ; 561
	i32 188, ; 562
	i32 11, ; 563
	i32 77, ; 564
	i32 125, ; 565
	i32 82, ; 566
	i32 178, ; 567
	i32 65, ; 568
	i32 106, ; 569
	i32 64, ; 570
	i32 127, ; 571
	i32 121, ; 572
	i32 76, ; 573
	i32 258, ; 574
	i32 248, ; 575
	i32 8, ; 576
	i32 216, ; 577
	i32 2, ; 578
	i32 297, ; 579
	i32 43, ; 580
	i32 261, ; 581
	i32 155, ; 582
	i32 0, ; 583
	i32 127, ; 584
	i32 246, ; 585
	i32 23, ; 586
	i32 132, ; 587
	i32 204, ; 588
	i32 235, ; 589
	i32 28, ; 590
	i32 203, ; 591
	i32 61, ; 592
	i32 190, ; 593
	i32 89, ; 594
	i32 86, ; 595
	i32 147, ; 596
	i32 283, ; 597
	i32 192, ; 598
	i32 35, ; 599
	i32 85, ; 600
	i32 224, ; 601
	i32 307, ; 602
	i32 177, ; 603
	i32 49, ; 604
	i32 6, ; 605
	i32 89, ; 606
	i32 307, ; 607
	i32 21, ; 608
	i32 161, ; 609
	i32 95, ; 610
	i32 49, ; 611
	i32 112, ; 612
	i32 240, ; 613
	i32 129, ; 614
	i32 75, ; 615
	i32 194, ; 616
	i32 296, ; 617
	i32 217, ; 618
	i32 239, ; 619
	i32 7, ; 620
	i32 189, ; 621
	i32 172, ; 622
	i32 109, ; 623
	i32 240, ; 624
	i32 226 ; 625
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.1xx @ af27162bee43b7fecdca59b4f67aa8c175cbc875"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
