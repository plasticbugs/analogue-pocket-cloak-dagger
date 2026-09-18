module t65_alu_Brtl
  (input  [1:0] mode,
   input  bcd_en,
   input  [4:0] op,
   input  [7:0] busa,
   input  [7:0] busb,
   input  [7:0] p_in,
   output [7:0] p_out,
   output [7:0] q);
  wire adc_z;
  wire adc_c;
  wire adc_v;
  wire adc_n;
  wire [7:0] adc_q;
  wire sbc_z;
  wire sbc_c;
  wire sbc_v;
  wire sbc_n;
  wire [7:0] sbc_q;
  wire [7:0] sbx_q;
  wire [3:0] n3122;
  wire n3123;
  wire [4:0] n3124;
  wire [6:0] n3125;
  wire [3:0] n3126;
  wire [4:0] n3128;
  wire [6:0] n3129;
  wire [6:0] n3130;
  wire [3:0] n3131;
  wire n3132;
  wire [4:0] n3133;
  wire [6:0] n3134;
  wire [3:0] n3135;
  wire [4:0] n3137;
  wire [6:0] n3138;
  wire [6:0] n3139;
  wire [3:0] n3140;
  wire n3142;
  wire [3:0] n3143;
  wire n3145;
  wire n3146;
  wire n3149;
  wire [4:0] n3150;
  wire n3152;
  wire n3153;
  wire n3154;
  wire n3155;
  wire [5:0] n3156;
  wire [5:0] n3158;
  wire [5:0] n3159;
  wire [5:0] n3160;
  wire n3161;
  wire [6:0] n3162;
  wire n3163;
  wire [6:0] n3164;
  wire n3165;
  wire n3166;
  wire [3:0] n3167;
  wire [4:0] n3168;
  wire [6:0] n3169;
  wire [3:0] n3170;
  wire [4:0] n3172;
  wire [6:0] n3173;
  wire [6:0] n3174;
  wire n3175;
  wire n3176;
  wire n3177;
  wire n3178;
  wire n3179;
  wire n3180;
  wire n3181;
  wire n3182;
  wire n3183;
  wire [4:0] n3184;
  wire n3186;
  wire n3187;
  wire n3188;
  wire n3189;
  wire [5:0] n3190;
  wire [5:0] n3192;
  wire [5:0] n3193;
  wire [5:0] n3194;
  wire n3195;
  wire [6:0] n3196;
  wire n3197;
  wire [6:0] n3198;
  wire n3199;
  wire n3200;
  wire [6:0] n3201;
  wire [3:0] n3202;
  wire [6:0] n3203;
  wire [3:0] n3204;
  wire [7:0] n3205;
  wire n3216;
  wire n3218;
  wire n3219;
  wire n3221;
  wire n3222;
  wire n3224;
  wire n3225;
  wire n3227;
  wire n3228;
  wire n3230;
  wire n3231;
  wire n3233;
  wire n3234;
  wire n3237;
  wire n3239;
  wire n3240;
  wire n3241;
  wire [3:0] n3242;
  wire [4:0] n3243;
  wire [6:0] n3244;
  wire [3:0] n3245;
  wire [4:0] n3247;
  wire [5:0] n3248;
  wire [6:0] n3249;
  wire [6:0] n3250;
  wire [3:0] n3251;
  wire [4:0] n3253;
  wire [5:0] n3254;
  wire [3:0] n3255;
  wire n3256;
  wire [4:0] n3257;
  wire [5:0] n3258;
  wire [5:0] n3259;
  wire [3:0] n3260;
  wire n3262;
  wire [3:0] n3263;
  wire n3265;
  wire n3266;
  wire n3269;
  wire n3270;
  wire n3271;
  wire n3272;
  wire n3273;
  wire n3274;
  wire n3275;
  wire n3276;
  wire n3277;
  wire n3278;
  wire n3279;
  wire [3:0] n3280;
  wire [3:0] n3281;
  wire [7:0] n3282;
  wire n3283;
  wire n3284;
  wire n3285;
  wire [4:0] n3286;
  wire [4:0] n3288;
  wire [4:0] n3289;
  wire [4:0] n3290;
  wire [3:0] n3291;
  wire [4:0] n3293;
  wire [5:0] n3294;
  wire [3:0] n3295;
  wire n3296;
  wire n3297;
  wire [6:0] n3298;
  wire n3299;
  wire [4:0] n3300;
  wire [5:0] n3301;
  wire [5:0] n3302;
  wire n3303;
  wire [4:0] n3304;
  wire [4:0] n3306;
  wire [4:0] n3307;
  wire [4:0] n3308;
  wire n3309;
  wire [4:0] n3310;
  wire [4:0] n3311;
  wire n3312;
  wire n3313;
  wire [5:0] n3314;
  wire [5:0] n3315;
  wire [3:0] n3316;
  wire [6:0] n3317;
  wire [3:0] n3318;
  wire [7:0] n3319;
  wire [7:0] n3326;
  wire n3328;
  wire [7:0] n3329;
  wire n3331;
  wire [7:0] n3332;
  wire n3334;
  wire n3336;
  wire n3338;
  wire n3340;
  wire n3342;
  wire [6:0] n3343;
  wire [7:0] n3345;
  wire n3346;
  wire n3348;
  wire [6:0] n3349;
  wire n3350;
  wire [7:0] n3351;
  wire n3352;
  wire n3354;
  wire [6:0] n3355;
  wire [7:0] n3357;
  wire n3358;
  wire n3360;
  wire n3361;
  wire [6:0] n3362;
  wire [7:0] n3363;
  wire n3364;
  wire n3366;
  wire n3367;
  wire [6:0] n3368;
  wire [6:0] n3369;
  wire [6:0] n3370;
  wire [7:0] n3371;
  wire n3372;
  wire n3373;
  wire n3374;
  wire n3375;
  wire n3376;
  wire [3:0] n3377;
  wire [3:0] n3378;
  wire [3:0] n3379;
  wire n3381;
  wire [3:0] n3382;
  wire [3:0] n3384;
  wire [3:0] n3385;
  wire [3:0] n3386;
  wire [3:0] n3387;
  wire [3:0] n3388;
  wire [3:0] n3389;
  wire n3391;
  wire [3:0] n3392;
  wire [3:0] n3394;
  wire n3397;
  wire [3:0] n3398;
  wire [3:0] n3399;
  wire n3400;
  wire n3401;
  wire [7:0] n3402;
  wire [7:0] n3403;
  wire n3405;
  wire n3406;
  wire n3408;
  wire [7:0] n3410;
  wire n3412;
  wire [7:0] n3414;
  wire n3416;
  wire [14:0] n3417;
  wire n3418;
  reg n3419;
  wire n3420;
  reg n3421;
  wire n3423;
  reg [7:0] n3425;
  reg [7:0] n3426;
  wire n3428;
  wire n3430;
  wire n3432;
  wire n3433;
  wire n3435;
  wire n3436;
  wire n3438;
  wire n3439;
  wire [7:0] n3440;
  wire n3442;
  wire n3445;
  wire n3447;
  wire n3448;
  wire n3449;
  wire n3451;
  wire n3454;
  wire n3456;
  wire n3457;
  wire n3459;
  wire n3462;
  wire [4:0] n3463;
  reg n3464;
  wire n3465;
  reg n3466;
  reg n3467;
  wire [3:0] n3468;
  wire n3470;
  wire [7:0] n3471;
  wire [7:0] n3473;
  assign p_out = n3473; //(module output)
  assign q = n3471; //(module output)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:73:15 */
  assign adc_z = n3149; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:74:15 */
  assign adc_c = n3200; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:75:15 */
  assign adc_v = n3183; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:76:15 */
  assign adc_n = n3175; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:77:15 */
  assign adc_q = n3205; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:78:15 */
  assign sbc_z = n3269; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:79:15 */
  assign sbc_c = n3271; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:80:15 */
  assign sbc_v = n3278; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:81:15 */
  assign sbc_n = n3279; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:82:15 */
  assign sbc_q = n3319; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:83:15 */
  assign sbx_q = n3282; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:31 */
  assign n3122 = busa[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:50 */
  assign n3123 = p_in[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:44 */
  assign n3124 = {n3122, n3123};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:11 */
  assign n3125 = {2'b0, n3124};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:86 */
  assign n3126 = busb[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:99 */
  assign n3128 = {n3126, 1'b1};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:66 */
  assign n3129 = {2'b0, n3128};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:92:64 */
  assign n3130 = n3125 + n3129;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:31 */
  assign n3131 = busa[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:48 */
  assign n3132 = n3130[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:44 */
  assign n3133 = {n3131, n3132};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:11 */
  assign n3134 = {2'b0, n3133};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:79 */
  assign n3135 = busb[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:92 */
  assign n3137 = {n3135, 1'b1};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:59 */
  assign n3138 = {2'b0, n3137};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:93:57 */
  assign n3139 = n3134 + n3138;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:100:10 */
  assign n3140 = n3130[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:100:23 */
  assign n3142 = n3140 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:100:33 */
  assign n3143 = n3139[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:100:46 */
  assign n3145 = n3143 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:100:27 */
  assign n3146 = n3145 & n3142;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:100:5 */
  assign n3149 = n3146 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:106:10 */
  assign n3150 = n3130[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:106:23 */
  assign n3152 = $unsigned(n3150) > $unsigned(5'b01001);
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:106:35 */
  assign n3153 = p_in[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:106:27 */
  assign n3154 = n3153 & n3152;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:106:50 */
  assign n3155 = bcd_en & n3154;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:107:27 */
  assign n3156 = n3130[6:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:107:40 */
  assign n3158 = n3156 + 6'b000110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3159 = n3130[6:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:106:5 */
  assign n3160 = n3155 ? n3158 : n3159;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3161 = n3130[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3162 = {n3160, n3161};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:110:12 */
  assign n3163 = n3162[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3164 = {n3160, n3161};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:110:21 */
  assign n3165 = n3164[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:110:16 */
  assign n3166 = n3163 | n3165;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:31 */
  assign n3167 = busa[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:44 */
  assign n3168 = {n3167, n3166};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:11 */
  assign n3169 = {2'b0, n3168};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:75 */
  assign n3170 = busb[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:88 */
  assign n3172 = {n3170, 1'b1};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:55 */
  assign n3173 = {2'b0, n3172};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:111:53 */
  assign n3174 = n3169 + n3173;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:113:16 */
  assign n3175 = n3174[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:17 */
  assign n3176 = n3174[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:29 */
  assign n3177 = busa[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:21 */
  assign n3178 = n3176 ^ n3177;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:47 */
  assign n3179 = busa[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:59 */
  assign n3180 = busb[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:51 */
  assign n3181 = n3179 ^ n3180;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:38 */
  assign n3182 = ~n3181;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:114:34 */
  assign n3183 = n3178 & n3182;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:120:10 */
  assign n3184 = n3174[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:120:23 */
  assign n3186 = $unsigned(n3184) > $unsigned(5'b01001);
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:120:35 */
  assign n3187 = p_in[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:120:27 */
  assign n3188 = n3187 & n3186;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:120:50 */
  assign n3189 = bcd_en & n3188;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:121:27 */
  assign n3190 = n3174[6:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:121:40 */
  assign n3192 = n3190 + 6'b000110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3193 = n3174[6:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:120:5 */
  assign n3194 = n3189 ? n3192 : n3193;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3195 = n3174[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3196 = {n3194, n3195};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:124:16 */
  assign n3197 = n3196[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3198 = {n3194, n3195};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:124:25 */
  assign n3199 = n3198[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:124:20 */
  assign n3200 = n3197 | n3199;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3201 = {n3194, n3195};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:126:33 */
  assign n3202 = n3201[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3203 = {n3160, n3161};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:126:50 */
  assign n3204 = n3203[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:126:46 */
  assign n3205 = {n3202, n3204};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:136:12 */
  assign n3216 = op == 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:137:12 */
  assign n3218 = op == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:136:24 */
  assign n3219 = n3216 | n3218;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:138:12 */
  assign n3221 = op == 5'b00101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:137:24 */
  assign n3222 = n3219 | n3221;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:139:12 */
  assign n3224 = op == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:138:24 */
  assign n3225 = n3222 | n3224;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:140:12 */
  assign n3227 = op == 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:139:24 */
  assign n3228 = n3225 | n3227;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:141:12 */
  assign n3230 = op == 5'b01011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:140:24 */
  assign n3231 = n3228 | n3230;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:143:12 */
  assign n3233 = op == 5'b01110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:141:24 */
  assign n3234 = n3231 | n3233;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:136:5 */
  assign n3237 = n3234 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:148:14 */
  assign n3239 = p_in[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:148:26 */
  assign n3240 = ~n3237;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:148:23 */
  assign n3241 = n3239 | n3240;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:31 */
  assign n3242 = busa[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:44 */
  assign n3243 = {n3242, n3241};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:11 */
  assign n3244 = {2'b0, n3243};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:75 */
  assign n3245 = busb[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:88 */
  assign n3247 = {n3245, 1'b1};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:55 */
  assign n3248 = {1'b0, n3247};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:53 */
  assign n3249 = {1'b0, n3248};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:149:53 */
  assign n3250 = n3244 - n3249;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:31 */
  assign n3251 = busa[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:44 */
  assign n3253 = {n3251, 1'b0};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:11 */
  assign n3254 = {1'b0, n3253};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:77 */
  assign n3255 = busb[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:94 */
  assign n3256 = n3250[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:90 */
  assign n3257 = {n3255, n3256};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:57 */
  assign n3258 = {1'b0, n3257};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:150:55 */
  assign n3259 = n3254 - n3258;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:157:10 */
  assign n3260 = n3250[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:157:23 */
  assign n3262 = n3260 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:157:33 */
  assign n3263 = n3259[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:157:46 */
  assign n3265 = n3263 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:157:27 */
  assign n3266 = n3265 & n3262;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:157:5 */
  assign n3269 = n3266 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:163:20 */
  assign n3270 = n3259[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:163:14 */
  assign n3271 = ~n3270;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:17 */
  assign n3272 = n3259[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:29 */
  assign n3273 = busa[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:21 */
  assign n3274 = n3272 ^ n3273;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:43 */
  assign n3275 = busa[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:55 */
  assign n3276 = busb[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:47 */
  assign n3277 = n3275 ^ n3276;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:164:34 */
  assign n3278 = n3274 & n3277;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:165:16 */
  assign n3279 = n3259[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:167:33 */
  assign n3280 = n3259[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:167:50 */
  assign n3281 = n3250[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:167:46 */
  assign n3282 = {n3280, n3281};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:169:12 */
  assign n3283 = p_in[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:169:27 */
  assign n3284 = bcd_en & n3283;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:170:12 */
  assign n3285 = n3250[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:171:29 */
  assign n3286 = n3250[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:171:42 */
  assign n3288 = n3286 - 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3289 = n3250[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:170:7 */
  assign n3290 = n3285 ? n3288 : n3289;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:33 */
  assign n3291 = busa[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:46 */
  assign n3293 = {n3291, 1'b0};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:13 */
  assign n3294 = {1'b0, n3293};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:79 */
  assign n3295 = busb[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3296 = n3250[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3297 = n3250[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3298 = {n3297, n3290, n3296};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:96 */
  assign n3299 = n3298[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:92 */
  assign n3300 = {n3295, n3299};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:59 */
  assign n3301 = {1'b0, n3300};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:173:57 */
  assign n3302 = n3294 - n3301;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:174:12 */
  assign n3303 = n3302[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:175:29 */
  assign n3304 = n3302[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:175:42 */
  assign n3306 = n3304 - 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:131:14 */
  assign n3307 = n3302[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:174:7 */
  assign n3308 = n3303 ? n3306 : n3307;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:131:14 */
  assign n3309 = n3302[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3310 = n3250[5:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:169:5 */
  assign n3311 = n3284 ? n3290 : n3310;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3312 = n3250[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3313 = n3250[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:169:5 */
  assign n3314 = {n3308, n3309};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:169:5 */
  assign n3315 = n3284 ? n3314 : n3259;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:179:33 */
  assign n3316 = n3315[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3317 = {n3312, n3311, n3313};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:179:50 */
  assign n3318 = n3317[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:179:46 */
  assign n3319 = {n3316, n3318};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:196:21 */
  assign n3326 = busa | busb;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:195:7 */
  assign n3328 = op == 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:198:21 */
  assign n3329 = busa & busb;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:197:7 */
  assign n3331 = op == 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:200:21 */
  assign n3332 = busa ^ busb;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:199:7 */
  assign n3334 = op == 5'b00010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:201:7 */
  assign n3336 = op == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:205:7 */
  assign n3338 = op == 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:207:7 */
  assign n3340 = op == 5'b10001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:210:7 */
  assign n3342 = op == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:215:20 */
  assign n3343 = busa[6:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:215:33 */
  assign n3345 = {n3343, 1'b0};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:216:30 */
  assign n3346 = busa[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:214:7 */
  assign n3348 = op == 5'b01000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:218:20 */
  assign n3349 = busa[6:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:218:39 */
  assign n3350 = p_in[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:218:33 */
  assign n3351 = {n3349, n3350};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:219:30 */
  assign n3352 = busa[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:217:7 */
  assign n3354 = op == 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:221:26 */
  assign n3355 = busa[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:221:20 */
  assign n3357 = {1'b0, n3355};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:222:30 */
  assign n3358 = busa[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:220:7 */
  assign n3360 = op == 5'b01010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:224:20 */
  assign n3361 = p_in[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:224:35 */
  assign n3362 = busa[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:224:29 */
  assign n3363 = {n3361, n3362};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:225:30 */
  assign n3364 = busa[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:223:7 */
  assign n3366 = op == 5'b01011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:227:20 */
  assign n3367 = p_in[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:227:36 */
  assign n3368 = busa[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:227:57 */
  assign n3369 = busb[7:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:227:49 */
  assign n3370 = n3368 & n3369;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:227:29 */
  assign n3371 = {n3367, n3370};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:228:29 */
  assign n3372 = n3371[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:228:40 */
  assign n3373 = n3371[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:228:33 */
  assign n3374 = n3372 ^ n3373;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:230:16 */
  assign n3375 = p_in[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:230:29 */
  assign n3376 = bcd_en & n3375;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:231:19 */
  assign n3377 = busa[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:231:40 */
  assign n3378 = busb[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:231:32 */
  assign n3379 = n3377 & n3378;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:231:54 */
  assign n3381 = $unsigned(n3379) > $unsigned(4'b0100);
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:232:62 */
  assign n3382 = n3371[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:232:76 */
  assign n3384 = n3382 + 4'b0110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:187:14 */
  assign n3385 = n3371[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:231:11 */
  assign n3386 = n3381 ? n3384 : n3385;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:234:19 */
  assign n3387 = busa[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:234:40 */
  assign n3388 = busb[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:234:32 */
  assign n3389 = n3387 & n3388;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:234:54 */
  assign n3391 = $unsigned(n3389) > $unsigned(4'b0100);
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:235:62 */
  assign n3392 = n3371[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:235:76 */
  assign n3394 = n3392 + 4'b0110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:234:11 */
  assign n3397 = n3391 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:187:14 */
  assign n3398 = n3371[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:234:11 */
  assign n3399 = n3391 ? n3394 : n3398;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:241:31 */
  assign n3400 = n3371[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:230:9 */
  assign n3401 = n3376 ? n3397 : n3400;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:230:9 */
  assign n3402 = {n3399, n3386};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:230:9 */
  assign n3403 = n3376 ? n3402 : n3371;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:226:7 */
  assign n3405 = op == 5'b01111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:244:30 */
  assign n3406 = busb[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:243:7 */
  assign n3408 = op == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:246:48 */
  assign n3410 = busa - 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:245:7 */
  assign n3412 = op == 5'b01101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:248:48 */
  assign n3414 = busa + 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:247:7 */
  assign n3416 = op == 5'b01110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:194:5 */
  assign n3417 = {n3416, n3412, n3408, n3405, n3366, n3360, n3354, n3348, n3342, n3340, n3338, n3336, n3334, n3331, n3328};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3418 = p_in[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3417)
      15'b100000000000000: n3419 = n3418;
      15'b010000000000000: n3419 = n3418;
      15'b001000000000000: n3419 = n3418;
      15'b000100000000000: n3419 = n3401;
      15'b000010000000000: n3419 = n3364;
      15'b000001000000000: n3419 = n3358;
      15'b000000100000000: n3419 = n3352;
      15'b000000010000000: n3419 = n3346;
      15'b000000001000000: n3419 = sbc_c;
      15'b000000000100000: n3419 = sbc_c;
      15'b000000000010000: n3419 = sbc_c;
      15'b000000000001000: n3419 = adc_c;
      15'b000000000000100: n3419 = n3418;
      15'b000000000000010: n3419 = n3418;
      15'b000000000000001: n3419 = n3418;
      default: n3419 = n3418;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3420 = p_in[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3417)
      15'b100000000000000: n3421 = n3420;
      15'b010000000000000: n3421 = n3420;
      15'b001000000000000: n3421 = n3406;
      15'b000100000000000: n3421 = n3374;
      15'b000010000000000: n3421 = n3420;
      15'b000001000000000: n3421 = n3420;
      15'b000000100000000: n3421 = n3420;
      15'b000000010000000: n3421 = n3420;
      15'b000000001000000: n3421 = sbc_v;
      15'b000000000100000: n3421 = n3420;
      15'b000000000010000: n3421 = n3420;
      15'b000000000001000: n3421 = adc_v;
      15'b000000000000100: n3421 = n3420;
      15'b000000000000010: n3421 = n3420;
      15'b000000000000001: n3421 = n3420;
      default: n3421 = n3420;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3423 = p_in[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3417)
      15'b100000000000000: n3425 = n3414;
      15'b010000000000000: n3425 = n3410;
      15'b001000000000000: n3425 = busa;
      15'b000100000000000: n3425 = n3371;
      15'b000010000000000: n3425 = n3363;
      15'b000001000000000: n3425 = n3357;
      15'b000000100000000: n3425 = n3351;
      15'b000000010000000: n3425 = n3345;
      15'b000000001000000: n3425 = sbc_q;
      15'b000000000100000: n3425 = sbx_q;
      15'b000000000010000: n3425 = busa;
      15'b000000000001000: n3425 = adc_q;
      15'b000000000000100: n3425 = n3332;
      15'b000000000000010: n3425 = n3329;
      15'b000000000000001: n3425 = n3326;
      default: n3425 = busa;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3417)
      15'b100000000000000: n3426 = busa;
      15'b010000000000000: n3426 = busa;
      15'b001000000000000: n3426 = busa;
      15'b000100000000000: n3426 = n3403;
      15'b000010000000000: n3426 = busa;
      15'b000001000000000: n3426 = busa;
      15'b000000100000000: n3426 = busa;
      15'b000000010000000: n3426 = busa;
      15'b000000001000000: n3426 = busa;
      15'b000000000100000: n3426 = busa;
      15'b000000000010000: n3426 = busa;
      15'b000000000001000: n3426 = busa;
      15'b000000000000100: n3426 = busa;
      15'b000000000000010: n3426 = busa;
      15'b000000000000001: n3426 = busa;
      default: n3426 = busa;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:255:7 */
  assign n3428 = op == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:258:7 */
  assign n3430 = op == 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:258:22 */
  assign n3432 = op == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:258:22 */
  assign n3433 = n3430 | n3432;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:258:33 */
  assign n3435 = op == 5'b10001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:258:33 */
  assign n3436 = n3433 | n3435;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:261:7 */
  assign n3438 = op == 5'b00100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:263:30 */
  assign n3439 = busb[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:264:18 */
  assign n3440 = busa & busb;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:264:28 */
  assign n3442 = n3440 == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:264:9 */
  assign n3445 = n3442 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:262:7 */
  assign n3447 = op == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:270:29 */
  assign n3448 = n3425[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:271:29 */
  assign n3449 = n3425[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:272:16 */
  assign n3451 = n3425 == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:272:9 */
  assign n3454 = n3451 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:269:7 */
  assign n3456 = op == 5'b10000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:278:29 */
  assign n3457 = n3425[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:279:16 */
  assign n3459 = n3425 == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:279:9 */
  assign n3462 = n3459 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:254:5 */
  assign n3463 = {n3456, n3447, n3438, n3436, n3428};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3463)
      5'b10000: n3464 = n3449;
      5'b01000: n3464 = n3419;
      5'b00100: n3464 = n3419;
      5'b00010: n3464 = n3419;
      5'b00001: n3464 = n3419;
      default: n3464 = n3419;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3465 = p_in[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3463)
      5'b10000: n3466 = n3454;
      5'b01000: n3466 = n3445;
      5'b00100: n3466 = n3465;
      5'b00010: n3466 = sbc_z;
      5'b00001: n3466 = adc_z;
      default: n3466 = n3462;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3463)
      5'b10000: n3467 = n3448;
      5'b01000: n3467 = n3439;
      5'b00100: n3467 = n3423;
      5'b00010: n3467 = sbc_n;
      5'b00001: n3467 = adc_n;
      default: n3467 = n3457;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3468 = p_in[5:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:286:10 */
  assign n3470 = op == 5'b01111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:286:5 */
  assign n3471 = n3470 ? n3426 : n3425;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3473 = {n3467, n3421, n3468, n3466, n3464};
endmodule

module t65_mcode_Brtl
  (input  [1:0] mode,
   input  [7:0] ir,
   input  [2:0] mcycle,
   input  [7:0] p,
   input  rdy_mod,
   output [2:0] lcycle,
   output [4:0] alu_op,
   output [3:0] set_busa_to,
   output [1:0] set_addr_to,
   output [3:0] write_data,
   output [1:0] jump,
   output [1:0] baadd,
   output [1:0] baquirk,
   output breakatna,
   output adadd,
   output addy,
   output pcadd,
   output inc_s,
   output dec_s,
   output lda,
   output ldp,
   output ldx,
   output ldy,
   output lds,
   output lddi,
   output ldalu,
   output ldad,
   output ldbal,
   output ldbah,
   output savep,
   output write);
  wire branch;
  wire alumore;
  wire [2:0] n924;
  wire n925;
  wire n926;
  wire n928;
  wire n929;
  wire n931;
  wire n932;
  wire n933;
  wire n935;
  wire n936;
  wire n938;
  wire n939;
  wire n940;
  wire n942;
  wire n943;
  wire n945;
  wire n946;
  wire n947;
  wire n949;
  wire n950;
  wire [6:0] n951;
  reg n952;
  wire [2:0] n955;
  wire [1:0] n956;
  wire [2:0] n957;
  wire n959;
  wire n960;
  wire [3:0] n963;
  wire [3:0] n965;
  wire n967;
  wire [2:0] n968;
  wire n970;
  wire n971;
  wire [3:0] n974;
  wire [3:0] n976;
  wire n978;
  wire [2:0] n979;
  wire n981;
  wire [3:0] n984;
  wire n987;
  wire [2:0] n988;
  wire n990;
  wire [2:0] n991;
  wire n993;
  wire n994;
  wire [2:0] n995;
  wire n997;
  wire n998;
  wire n999;
  wire [3:0] n1002;
  wire [3:0] n1004;
  wire n1006;
  wire [2:0] n1007;
  reg [3:0] n1011;
  reg [3:0] n1013;
  reg n1015;
  wire n1017;
  wire [1:0] n1018;
  wire n1019;
  wire n1021;
  wire n1022;
  wire n1024;
  wire n1025;
  wire n1028;
  wire n1030;
  wire n1032;
  wire n1034;
  wire [2:0] n1035;
  wire n1037;
  wire [3:0] n1040;
  wire n1043;
  wire [2:0] n1044;
  reg [3:0] n1046;
  reg n1051;
  reg n1055;
  reg n1057;
  reg n1059;
  wire n1061;
  wire [1:0] n1062;
  wire n1063;
  wire n1064;
  wire n1067;
  wire n1069;
  reg [3:0] n1072;
  reg n1074;
  wire n1076;
  wire [1:0] n1077;
  wire n1078;
  wire n1079;
  wire n1082;
  wire n1084;
  reg [3:0] n1087;
  reg n1089;
  wire n1091;
  wire [3:0] n1092;
  reg [3:0] n1094;
  reg [3:0] n1097;
  reg n1100;
  reg n1103;
  reg n1106;
  reg n1109;
  wire [1:0] n1111;
  wire n1113;
  wire n1114;
  wire n1115;
  wire n1117;
  wire n1118;
  wire n1119;
  wire n1120;
  wire n1121;
  wire n1123;
  wire [3:0] n1126;
  wire [3:0] n1127;
  wire [4:0] n1128;
  wire n1130;
  wire n1132;
  wire n1134;
  wire n1136;
  wire n1138;
  wire n1140;
  wire [5:0] n1141;
  reg [1:0] n1148;
  reg [3:0] n1152;
  reg [1:0] n1155;
  reg n1160;
  reg n1163;
  reg n1168;
  wire n1170;
  wire n1172;
  wire n1174;
  wire n1176;
  wire n1178;
  wire n1180;
  wire [4:0] n1181;
  reg [1:0] n1186;
  reg [3:0] n1189;
  reg [1:0] n1193;
  reg n1197;
  reg n1200;
  reg n1204;
  wire n1206;
  wire n1208;
  wire n1210;
  wire n1212;
  wire n1214;
  wire n1216;
  wire [4:0] n1217;
  reg [3:0] n1219;
  reg [1:0] n1225;
  reg [1:0] n1228;
  reg n1233;
  reg n1236;
  reg n1239;
  wire n1241;
  wire n1243;
  wire n1245;
  wire n1247;
  wire n1249;
  wire n1251;
  wire [4:0] n1252;
  reg [1:0] n1257;
  reg [1:0] n1261;
  reg n1265;
  reg n1268;
  wire n1270;
  wire n1272;
  wire n1273;
  wire n1274;
  wire [2:0] n1277;
  wire n1280;
  wire n1281;
  wire n1282;
  wire n1283;
  wire [3:0] n1284;
  wire n1286;
  wire n1288;
  wire n1290;
  wire [3:0] n1292;
  wire n1295;
  wire n1297;
  wire n1299;
  wire [3:0] n1301;
  wire n1304;
  wire n1306;
  wire [3:0] n1307;
  reg [3:0] n1310;
  reg n1312;
  wire [1:0] n1316;
  wire [3:0] n1317;
  wire n1319;
  wire n1321;
  wire n1323;
  wire [1:0] n1324;
  reg [1:0] n1326;
  reg [3:0] n1327;
  reg n1330;
  reg n1332;
  wire n1334;
  wire n1336;
  wire n1337;
  wire n1339;
  wire n1340;
  wire n1342;
  wire n1343;
  wire n1345;
  wire n1346;
  wire n1347;
  wire [2:0] n1350;
  wire [3:0] n1352;
  wire n1354;
  wire n1356;
  wire n1358;
  wire n1360;
  wire n1362;
  wire n1364;
  wire n1366;
  wire n1368;
  wire [3:0] n1369;
  reg n1371;
  reg n1374;
  reg n1375;
  reg n1376;
  wire n1378;
  wire n1379;
  wire n1380;
  wire n1381;
  wire n1384;
  wire n1386;
  wire n1388;
  wire n1389;
  wire n1390;
  wire n1391;
  wire [1:0] n1394;
  wire n1396;
  wire n1398;
  wire n1400;
  wire n1402;
  wire [3:0] n1403;
  reg [3:0] n1405;
  reg [1:0] n1408;
  reg n1411;
  reg n1413;
  reg n1415;
  wire n1417;
  wire n1419;
  wire n1420;
  wire n1422;
  wire n1423;
  wire n1425;
  wire n1426;
  wire n1428;
  wire n1430;
  wire [1:0] n1431;
  reg [1:0] n1434;
  wire n1436;
  wire n1438;
  wire n1439;
  wire n1441;
  wire n1442;
  wire n1444;
  wire n1446;
  wire [1:0] n1447;
  reg [3:0] n1449;
  wire n1451;
  wire n1453;
  wire n1455;
  wire [1:0] n1456;
  reg [3:0] n1458;
  wire n1460;
  wire n1462;
  wire n1464;
  wire n1466;
  wire n1468;
  wire [1:0] n1469;
  reg [3:0] n1471;
  wire n1473;
  wire n1475;
  wire n1476;
  wire n1483;
  wire n1485;
  wire n1486;
  wire n1488;
  wire n1489;
  wire n1491;
  wire n1492;
  wire n1499;
  wire n1501;
  wire n1502;
  wire n1504;
  wire n1506;
  wire [1:0] n1507;
  reg [3:0] n1509;
  wire n1511;
  wire n1513;
  wire n1514;
  wire n1516;
  wire n1518;
  wire n1520;
  wire [1:0] n1521;
  reg [3:0] n1523;
  wire n1525;
  wire n1527;
  wire n1529;
  wire [1:0] n1530;
  reg [1:0] n1533;
  wire n1535;
  wire [15:0] n1538;
  reg [2:0] n1544;
  reg [3:0] n1546;
  reg [1:0] n1548;
  reg [3:0] n1549;
  reg [1:0] n1551;
  reg n1553;
  reg n1555;
  reg n1558;
  reg n1560;
  reg n1563;
  reg n1565;
  reg n1567;
  reg n1569;
  reg n1571;
  reg n1573;
  wire n1575;
  wire n1577;
  wire n1578;
  wire n1580;
  wire n1581;
  wire n1583;
  wire n1584;
  wire n1586;
  wire n1587;
  wire [1:0] n1588;
  wire n1590;
  wire n1592;
  wire n1593;
  wire n1594;
  wire [2:0] n1597;
  wire [2:0] n1599;
  wire n1602;
  wire n1604;
  wire n1606;
  wire n1608;
  wire [2:0] n1609;
  wire n1611;
  wire n1614;
  wire n1616;
  wire n1618;
  wire n1619;
  wire n1620;
  wire [1:0] n1621;
  wire n1623;
  wire n1624;
  wire [1:0] n1627;
  wire n1630;
  wire n1633;
  wire n1635;
  wire n1637;
  wire n1639;
  wire [6:0] n1640;
  reg [3:0] n1642;
  reg [1:0] n1649;
  reg [1:0] n1652;
  reg [1:0] n1655;
  reg n1658;
  reg n1660;
  reg n1663;
  reg n1666;
  reg n1669;
  reg n1672;
  reg n1675;
  reg n1678;
  reg n1681;
  wire n1683;
  wire n1685;
  wire n1686;
  wire [2:0] n1687;
  wire n1689;
  wire n1691;
  wire n1693;
  reg [1:0] n1696;
  wire n1698;
  wire n1700;
  wire [2:0] n1701;
  wire n1703;
  wire n1705;
  wire n1706;
  wire n1708;
  wire n1709;
  wire n1711;
  wire n1712;
  wire n1714;
  wire n1716;
  wire n1718;
  wire [3:0] n1719;
  reg [3:0] n1724;
  reg n1729;
  reg n1731;
  wire n1733;
  reg [1:0] n1736;
  wire [3:0] n1737;
  wire [1:0] n1739;
  wire n1740;
  wire n1741;
  wire n1743;
  wire n1745;
  wire n1747;
  wire [3:0] n1748;
  wire n1750;
  wire [3:0] n1751;
  wire n1753;
  wire n1754;
  wire [3:0] n1755;
  wire n1757;
  wire n1758;
  wire [1:0] n1761;
  wire [1:0] n1763;
  wire n1765;
  wire n1767;
  wire [1:0] n1768;
  reg [1:0] n1770;
  reg n1771;
  wire n1773;
  wire n1775;
  wire n1776;
  wire [2:0] n1777;
  wire n1779;
  wire n1782;
  wire n1784;
  wire [2:0] n1785;
  wire n1787;
  wire n1790;
  wire n1792;
  wire n1794;
  wire [2:0] n1795;
  reg [1:0] n1798;
  reg [1:0] n1801;
  reg n1804;
  reg n1806;
  reg n1808;
  wire n1810;
  wire [1:0] n1811;
  wire n1813;
  wire n1814;
  wire n1815;
  wire n1817;
  wire n1818;
  wire n1819;
  wire n1820;
  wire n1821;
  wire n1823;
  wire n1824;
  wire n1825;
  wire n1827;
  wire n1829;
  wire n1831;
  wire n1834;
  wire n1836;
  wire n1838;
  wire n1840;
  wire n1841;
  wire n1842;
  wire [3:0] n1844;
  wire n1847;
  wire n1850;
  wire n1852;
  wire [3:0] n1853;
  reg [3:0] n1854;
  reg [1:0] n1859;
  reg [1:0] n1862;
  reg n1865;
  reg n1868;
  reg n1871;
  reg n1874;
  reg n1877;
  reg n1879;
  wire [1:0] n1880;
  wire n1882;
  wire n1884;
  wire n1886;
  wire [2:0] n1887;
  wire n1889;
  wire n1892;
  wire n1894;
  wire n1896;
  wire [2:0] n1897;
  reg [1:0] n1900;
  reg [1:0] n1903;
  reg n1906;
  reg n1908;
  wire [2:0] n1911;
  wire [3:0] n1912;
  wire [1:0] n1913;
  wire [1:0] n1914;
  wire n1915;
  wire n1917;
  wire n1919;
  wire n1920;
  wire n1922;
  wire n1923;
  wire n1925;
  wire n1927;
  wire n1929;
  wire n1930;
  wire n1932;
  wire n1933;
  wire [1:0] n1934;
  wire n1936;
  wire [4:0] n1937;
  wire n1939;
  wire n1940;
  wire n1941;
  wire n1942;
  wire n1944;
  wire n1946;
  wire [1:0] n1947;
  reg [1:0] n1951;
  reg n1954;
  wire n1956;
  wire n1958;
  wire [1:0] n1961;
  wire n1963;
  wire [1:0] n1966;
  wire n1968;
  wire n1970;
  wire [1:0] n1973;
  wire [1:0] n1976;
  wire [1:0] n1979;
  wire n1981;
  wire n1983;
  wire [3:0] n1984;
  reg [1:0] n1986;
  reg [1:0] n1990;
  reg [1:0] n1992;
  reg n1996;
  reg n1999;
  reg n2002;
  wire [2:0] n2005;
  wire [1:0] n2007;
  wire [1:0] n2008;
  wire [1:0] n2010;
  wire n2011;
  wire n2013;
  wire n2015;
  wire [2:0] n2016;
  wire n2018;
  wire n2021;
  wire n2023;
  wire n2025;
  wire [2:0] n2026;
  wire n2028;
  wire n2031;
  wire n2033;
  wire n2035;
  wire [3:0] n2036;
  reg [1:0] n2039;
  reg [1:0] n2043;
  reg n2046;
  reg n2049;
  reg n2051;
  reg n2053;
  wire [2:0] n2055;
  wire [1:0] n2056;
  wire [1:0] n2057;
  wire [1:0] n2059;
  wire n2061;
  wire n2062;
  wire n2063;
  wire n2065;
  wire n2067;
  wire n2069;
  wire [1:0] n2070;
  wire n2072;
  wire n2073;
  wire n2074;
  wire n2076;
  wire n2077;
  wire n2078;
  wire n2079;
  wire n2080;
  wire n2082;
  wire n2083;
  wire n2084;
  wire n2086;
  wire n2088;
  wire n2090;
  wire n2092;
  wire n2095;
  wire n2097;
  wire n2099;
  wire n2101;
  wire n2102;
  wire n2103;
  wire [3:0] n2105;
  wire n2108;
  wire n2110;
  wire [4:0] n2111;
  reg [3:0] n2112;
  reg [1:0] n2117;
  reg [1:0] n2121;
  reg n2124;
  reg n2127;
  reg n2130;
  reg n2133;
  reg n2136;
  reg n2139;
  reg n2141;
  wire [1:0] n2142;
  wire n2144;
  wire n2146;
  wire n2148;
  wire n2150;
  wire [2:0] n2151;
  wire n2153;
  wire n2156;
  wire n2158;
  wire n2160;
  wire [3:0] n2161;
  reg [1:0] n2164;
  reg [1:0] n2168;
  reg n2171;
  reg n2174;
  reg n2176;
  wire [2:0] n2179;
  wire [3:0] n2180;
  wire [1:0] n2181;
  wire [1:0] n2182;
  wire n2183;
  wire n2185;
  wire n2187;
  wire n2188;
  wire n2189;
  wire n2191;
  wire n2192;
  wire n2194;
  wire n2196;
  wire n2198;
  wire n2199;
  wire n2201;
  wire n2202;
  wire [2:0] n2205;
  wire n2207;
  wire n2209;
  wire n2211;
  wire [2:0] n2212;
  reg [1:0] n2216;
  reg n2219;
  reg n2222;
  wire n2224;
  wire [1:0] n2225;
  wire n2227;
  wire n2229;
  wire n2230;
  wire n2231;
  wire [2:0] n2234;
  wire [2:0] n2236;
  wire n2239;
  wire n2241;
  wire n2243;
  wire n2245;
  wire [2:0] n2246;
  wire n2248;
  wire [3:0] n2249;
  wire n2251;
  wire [1:0] n2254;
  wire n2255;
  wire n2256;
  wire n2258;
  wire n2259;
  wire n2262;
  wire [1:0] n2264;
  wire n2266;
  wire n2269;
  wire n2271;
  wire n2273;
  wire n2274;
  wire n2275;
  wire [1:0] n2276;
  wire n2278;
  wire n2279;
  wire [1:0] n2282;
  wire n2285;
  wire n2288;
  wire n2290;
  wire n2292;
  wire n2294;
  wire [6:0] n2295;
  reg [3:0] n2298;
  reg [1:0] n2305;
  reg [1:0] n2308;
  reg [1:0] n2313;
  reg [1:0] n2315;
  reg n2317;
  reg n2319;
  reg n2322;
  reg n2325;
  reg n2328;
  reg n2331;
  reg n2334;
  reg n2337;
  reg n2340;
  wire n2342;
  wire n2344;
  wire n2345;
  wire [1:0] n2346;
  wire n2348;
  wire n2349;
  wire n2350;
  wire n2352;
  wire n2353;
  wire n2354;
  wire n2355;
  wire n2356;
  wire n2358;
  wire n2359;
  wire n2360;
  wire n2362;
  wire n2364;
  wire n2366;
  wire n2368;
  wire n2371;
  wire n2373;
  wire n2375;
  wire n2376;
  wire n2377;
  wire n2380;
  wire n2382;
  wire n2384;
  wire n2385;
  wire n2386;
  wire [3:0] n2388;
  wire n2391;
  wire n2393;
  wire [4:0] n2394;
  reg [3:0] n2395;
  reg [1:0] n2401;
  reg [1:0] n2404;
  reg n2407;
  reg n2410;
  reg n2413;
  reg n2416;
  reg n2419;
  reg n2422;
  reg n2424;
  wire [1:0] n2425;
  wire n2427;
  wire n2428;
  wire n2429;
  wire n2431;
  wire n2433;
  wire n2435;
  wire [2:0] n2436;
  wire n2438;
  wire n2441;
  wire [2:0] n2442;
  wire n2444;
  wire n2447;
  wire n2449;
  wire n2451;
  wire [3:0] n2452;
  reg [1:0] n2456;
  reg [1:0] n2459;
  reg n2462;
  reg n2464;
  reg n2467;
  reg n2469;
  wire [2:0] n2472;
  wire [3:0] n2473;
  wire [1:0] n2474;
  wire [1:0] n2475;
  wire n2476;
  wire n2478;
  wire n2479;
  wire n2481;
  wire n2483;
  wire n2484;
  wire n2486;
  wire n2487;
  wire n2489;
  wire n2491;
  wire n2493;
  wire n2494;
  wire n2496;
  wire n2497;
  wire n2499;
  wire n2500;
  wire [1:0] n2501;
  wire n2503;
  wire n2505;
  wire n2506;
  wire n2507;
  wire [2:0] n2510;
  wire [2:0] n2512;
  wire n2515;
  wire n2517;
  wire n2519;
  wire [2:0] n2520;
  wire n2522;
  wire [3:0] n2523;
  wire n2525;
  wire [1:0] n2528;
  wire n2529;
  wire n2530;
  wire n2532;
  wire n2533;
  wire n2536;
  wire [1:0] n2538;
  wire n2540;
  wire n2543;
  wire n2545;
  wire n2547;
  wire n2548;
  wire n2549;
  wire [1:0] n2550;
  wire n2552;
  wire n2553;
  wire [1:0] n2556;
  wire n2559;
  wire n2562;
  wire n2564;
  wire n2566;
  wire n2568;
  wire [5:0] n2569;
  reg [3:0] n2572;
  reg [1:0] n2577;
  reg [1:0] n2581;
  reg [1:0] n2585;
  reg [1:0] n2587;
  reg n2589;
  reg n2591;
  reg n2594;
  reg n2597;
  reg n2600;
  reg n2603;
  reg n2606;
  reg n2609;
  wire n2611;
  wire n2613;
  wire n2614;
  wire [1:0] n2615;
  wire n2617;
  wire n2618;
  wire n2619;
  wire n2621;
  wire n2622;
  wire n2623;
  wire n2624;
  wire n2625;
  wire n2627;
  wire n2628;
  wire n2629;
  wire n2631;
  wire n2633;
  wire n2635;
  wire n2637;
  wire n2639;
  wire n2642;
  wire n2644;
  wire n2646;
  wire n2648;
  wire n2649;
  wire n2650;
  wire [3:0] n2652;
  wire n2655;
  wire n2657;
  wire [5:0] n2658;
  reg [3:0] n2660;
  reg [1:0] n2666;
  reg [1:0] n2670;
  reg [1:0] n2674;
  reg n2677;
  reg n2680;
  reg n2683;
  reg n2686;
  reg n2689;
  reg n2692;
  reg n2694;
  wire [1:0] n2695;
  wire n2697;
  wire n2699;
  wire n2700;
  wire n2701;
  wire n2702;
  wire [1:0] n2703;
  wire n2705;
  wire n2706;
  wire n2708;
  wire n2709;
  wire n2711;
  wire n2713;
  wire [1:0] n2714;
  wire n2716;
  wire [3:0] n2717;
  wire n2719;
  wire n2720;
  wire [3:0] n2723;
  wire n2725;
  wire [2:0] n2726;
  wire n2728;
  wire [1:0] n2729;
  wire n2731;
  wire n2733;
  wire n2734;
  wire n2736;
  wire [1:0] n2737;
  reg [1:0] n2741;
  wire [1:0] n2743;
  wire n2746;
  wire n2749;
  wire n2751;
  wire n2753;
  wire [4:0] n2754;
  reg [3:0] n2755;
  reg [1:0] n2759;
  reg [1:0] n2763;
  reg [1:0] n2767;
  reg [1:0] n2769;
  reg n2771;
  reg n2774;
  reg n2777;
  reg n2779;
  wire [2:0] n2782;
  wire [3:0] n2783;
  wire [1:0] n2784;
  wire [1:0] n2785;
  wire [1:0] n2786;
  wire [1:0] n2788;
  wire n2790;
  wire n2791;
  wire n2793;
  wire n2795;
  wire n2796;
  wire n2797;
  wire n2799;
  wire n2800;
  wire n2802;
  wire n2804;
  wire n2806;
  wire n2807;
  wire n2809;
  wire n2810;
  wire n2812;
  wire n2813;
  wire [13:0] n2814;
  reg [2:0] n2817;
  reg [3:0] n2819;
  reg [1:0] n2821;
  reg [3:0] n2823;
  reg [1:0] n2825;
  reg [1:0] n2828;
  reg [1:0] n2831;
  reg n2834;
  reg n2837;
  reg n2840;
  reg n2843;
  reg n2846;
  reg n2849;
  reg n2851;
  reg n2853;
  reg n2855;
  reg n2856;
  reg n2857;
  reg n2859;
  reg n2862;
  reg n2865;
  reg n2868;
  reg n2871;
  reg n2874;
  reg n2877;
  reg n2880;
  wire [1:0] n2885;
  wire [2:0] n2886;
  wire [2:0] n2887;
  wire n2889;
  wire n2891;
  wire n2892;
  wire n2894;
  wire n2896;
  wire [2:0] n2897;
  reg [4:0] n2902;
  wire n2904;
  wire n2906;
  wire n2907;
  wire n2909;
  wire n2910;
  wire [2:0] n2911;
  wire n2913;
  wire n2915;
  wire n2916;
  wire n2918;
  wire [1:0] n2919;
  reg [4:0] n2923;
  wire n2925;
  wire [2:0] n2926;
  wire n2928;
  reg [4:0] n2931;
  wire n2933;
  wire [2:0] n2934;
  wire n2936;
  reg [4:0] n2939;
  wire [2:0] n2940;
  reg [4:0] n2941;
  wire n2943;
  wire [2:0] n2944;
  wire [30:0] n2945;
  wire n2947;
  wire n2949;
  wire n2951;
  wire n2953;
  wire n2955;
  wire n2957;
  wire n2959;
  wire [6:0] n2960;
  reg [4:0] n2969;
  wire n2971;
  wire [2:0] n2972;
  wire [30:0] n2973;
  wire [2:0] n2974;
  wire n2976;
  wire n2978;
  wire n2979;
  wire [4:0] n2982;
  wire n2985;
  wire [2:0] n2986;
  wire n2988;
  wire n2990;
  wire n2991;
  wire [4:0] n2994;
  wire n2997;
  wire n2999;
  wire n3001;
  wire [2:0] n3002;
  wire n3004;
  wire [4:0] n3007;
  wire n3010;
  wire n3012;
  wire n3014;
  wire [6:0] n3015;
  reg [4:0] n3021;
  wire n3023;
  wire [2:0] n3024;
  wire [30:0] n3025;
  wire n3027;
  wire [4:0] n3030;
  wire n3032;
  wire n3034;
  wire n3036;
  wire n3038;
  wire n3040;
  wire n3041;
  wire n3043;
  wire [2:0] n3044;
  wire [30:0] n3045;
  wire n3047;
  wire n3049;
  wire n3051;
  wire n3053;
  wire n3055;
  wire n3057;
  wire n3059;
  wire [6:0] n3060;
  reg [4:0] n3069;
  wire [2:0] n3070;
  wire [30:0] n3071;
  wire n3073;
  wire n3075;
  wire n3077;
  wire n3079;
  wire n3081;
  wire n3083;
  wire [2:0] n3084;
  wire n3086;
  wire [4:0] n3089;
  wire n3092;
  wire [6:0] n3093;
  reg [4:0] n3101;
  wire [4:0] n3102;
  wire [4:0] n3104;
  wire [4:0] n3106;
  wire [4:0] n3108;
  wire [4:0] n3110;
  reg [4:0] n3111;
  wire [2:0] n3112;
  reg [4:0] n3113;
  assign lcycle = n2817; //(module output)
  assign alu_op = n3113; //(module output)
  assign set_busa_to = n2819; //(module output)
  assign set_addr_to = n2821; //(module output)
  assign write_data = n2823; //(module output)
  assign jump = n2825; //(module output)
  assign baadd = n2828; //(module output)
  assign baquirk = n2831; //(module output)
  assign breakatna = n2834; //(module output)
  assign adadd = n2837; //(module output)
  assign addy = n2840; //(module output)
  assign pcadd = n2843; //(module output)
  assign inc_s = n2846; //(module output)
  assign dec_s = n2849; //(module output)
  assign lda = n2851; //(module output)
  assign ldp = n2853; //(module output)
  assign ldx = n2855; //(module output)
  assign ldy = n2856; //(module output)
  assign lds = n2857; //(module output)
  assign lddi = n2859; //(module output)
  assign ldalu = n2862; //(module output)
  assign ldad = n2865; //(module output)
  assign ldbal = n2868; //(module output)
  assign ldbah = n2871; //(module output)
  assign savep = n2874; //(module output)
  assign write = n2877; //(module output)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:96:10 */
  assign branch = n952; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:97:10 */
  assign alumore = n2880; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:101:10 */
  assign n924 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:102:20 */
  assign n925 = p[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:102:15 */
  assign n926 = ~n925;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:102:29 */
  assign n928 = n924 == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:103:20 */
  assign n929 = p[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:103:29 */
  assign n931 = n924 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:104:20 */
  assign n932 = p[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:104:15 */
  assign n933 = ~n932;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:104:29 */
  assign n935 = n924 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:105:20 */
  assign n936 = p[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:105:29 */
  assign n938 = n924 == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:106:20 */
  assign n939 = p[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:106:15 */
  assign n940 = ~n939;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:106:29 */
  assign n942 = n924 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:107:20 */
  assign n943 = p[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:107:29 */
  assign n945 = n924 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:108:20 */
  assign n946 = p[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:108:15 */
  assign n947 = ~n946;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:108:29 */
  assign n949 = n924 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:109:20 */
  assign n950 = p[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:101:3 */
  assign n951 = {n949, n945, n942, n938, n935, n931, n928};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:101:3 */
  always @*
    case (n951)
      7'b1000000: n952 = n947;
      7'b0100000: n952 = n943;
      7'b0010000: n952 = n940;
      7'b0001000: n952 = n936;
      7'b0000100: n952 = n933;
      7'b0000010: n952 = n929;
      7'b0000001: n952 = n926;
      default: n952 = n950;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:12 */
  assign n955 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:142:16 */
  assign n956 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:145:18 */
  assign n957 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:145:30 */
  assign n959 = n957 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:146:26 */
  assign n960 = ~rdy_mod;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:146:15 */
  assign n963 = n960 ? 4'b1011 : 4'b0011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:145:13 */
  assign n965 = n959 ? n963 : 4'b0011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:143:11 */
  assign n967 = n956 == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:156:18 */
  assign n968 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:156:30 */
  assign n970 = n968 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:157:26 */
  assign n971 = ~rdy_mod;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:157:15 */
  assign n974 = n971 ? 4'b1010 : 4'b0010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:156:13 */
  assign n976 = n970 ? n974 : 4'b0010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:154:11 */
  assign n978 = n956 == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:166:18 */
  assign n979 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:166:30 */
  assign n981 = n979 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:166:13 */
  assign n984 = n981 ? 4'b1001 : 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:166:13 */
  assign n987 = n981 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:18 */
  assign n988 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:30 */
  assign n990 = n988 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:42 */
  assign n991 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:54 */
  assign n993 = n991 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:37 */
  assign n994 = n990 | n993;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:66 */
  assign n995 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:78 */
  assign n997 = n995 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:61 */
  assign n998 = n994 | n997;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:173:26 */
  assign n999 = ~rdy_mod;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:173:15 */
  assign n1002 = n999 ? 4'b1001 : 4'b1000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:172:13 */
  assign n1004 = n998 ? n1002 : 4'b1000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:165:11 */
  assign n1006 = n956 == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:142:9 */
  assign n1007 = {n1006, n978, n967};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:142:9 */
  always @*
    case (n1007)
      3'b100: n1011 = n984;
      3'b010: n1011 = 4'b0010;
      3'b001: n1011 = 4'b0011;
      default: n1011 = 4'b0001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:142:9 */
  always @*
    case (n1007)
      3'b100: n1013 = n1004;
      3'b010: n1013 = n976;
      3'b001: n1013 = n965;
      default: n1013 = 4'b0001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:142:9 */
  always @*
    case (n1007)
      3'b100: n1015 = n987;
      3'b010: n1015 = 1'b0;
      3'b001: n1015 = 1'b0;
      default: n1015 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:141:7 */
  assign n1017 = n955 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:16 */
  assign n1018 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:188:18 */
  assign n1019 = ir[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:188:22 */
  assign n1021 = n1019 != 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:188:34 */
  assign n1022 = ir[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:188:38 */
  assign n1024 = n1022 != 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:188:29 */
  assign n1025 = n1021 | n1024;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:188:13 */
  assign n1028 = n1025 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:187:11 */
  assign n1030 = n1018 == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:191:11 */
  assign n1032 = n1018 == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:193:11 */
  assign n1034 = n1018 == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:198:18 */
  assign n1035 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:198:30 */
  assign n1037 = n1035 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:198:13 */
  assign n1040 = n1037 ? 4'b0100 : 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:198:13 */
  assign n1043 = n1037 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:9 */
  assign n1044 = {n1034, n1032, n1030};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:9 */
  always @*
    case (n1044)
      3'b100: n1046 = 4'b0000;
      3'b010: n1046 = 4'b0000;
      3'b001: n1046 = 4'b0000;
      default: n1046 = n1040;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:9 */
  always @*
    case (n1044)
      3'b100: n1051 = 1'b0;
      3'b010: n1051 = 1'b1;
      3'b001: n1051 = 1'b0;
      default: n1051 = 1'b1;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:9 */
  always @*
    case (n1044)
      3'b100: n1055 = 1'b1;
      3'b010: n1055 = 1'b0;
      3'b001: n1055 = 1'b0;
      default: n1055 = 1'b1;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:9 */
  always @*
    case (n1044)
      3'b100: n1057 = 1'b0;
      3'b010: n1057 = 1'b0;
      3'b001: n1057 = n1028;
      default: n1057 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:186:9 */
  always @*
    case (n1044)
      3'b100: n1059 = 1'b0;
      3'b010: n1059 = 1'b0;
      3'b001: n1059 = 1'b0;
      default: n1059 = n1043;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:184:7 */
  assign n1061 = n955 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:204:16 */
  assign n1062 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:206:18 */
  assign n1063 = ir[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:206:22 */
  assign n1064 = ~n1063;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:206:13 */
  assign n1067 = n1064 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:205:11 */
  assign n1069 = n1062 == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:204:9 */
  always @*
    case (n1069)
      1'b1: n1072 = 4'b0011;
      default: n1072 = 4'b0001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:204:9 */
  always @*
    case (n1069)
      1'b1: n1074 = n1067;
      default: n1074 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:203:7 */
  assign n1076 = n955 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:214:16 */
  assign n1077 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:216:16 */
  assign n1078 = ir[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:216:20 */
  assign n1079 = ~n1078;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:216:11 */
  assign n1082 = n1079 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:215:9 */
  assign n1084 = n1077 == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:214:9 */
  always @*
    case (n1084)
      1'b1: n1087 = 4'b0010;
      default: n1087 = 4'b0001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:214:9 */
  always @*
    case (n1084)
      1'b1: n1089 = n1082;
      default: n1089 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:213:7 */
  assign n1091 = n955 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  assign n1092 = {n1091, n1076, n1061, n1017};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  always @*
    case (n1092)
      4'b1000: n1094 = n1087;
      4'b0100: n1094 = n1072;
      4'b0010: n1094 = n1046;
      4'b0001: n1094 = n1011;
      default: n1094 = 4'b0001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  always @*
    case (n1092)
      4'b1000: n1097 = 4'b0000;
      4'b0100: n1097 = 4'b0000;
      4'b0010: n1097 = 4'b0000;
      4'b0001: n1097 = n1013;
      default: n1097 = 4'b0000;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  always @*
    case (n1092)
      4'b1000: n1100 = 1'b0;
      4'b0100: n1100 = 1'b0;
      4'b0010: n1100 = n1051;
      4'b0001: n1100 = 1'b0;
      default: n1100 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  always @*
    case (n1092)
      4'b1000: n1103 = n1089;
      4'b0100: n1103 = 1'b0;
      4'b0010: n1103 = n1055;
      4'b0001: n1103 = 1'b0;
      default: n1103 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  always @*
    case (n1092)
      4'b1000: n1106 = 1'b0;
      4'b0100: n1106 = n1074;
      4'b0010: n1106 = n1057;
      4'b0001: n1106 = 1'b0;
      default: n1106 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:140:5 */
  always @*
    case (n1092)
      4'b1000: n1109 = 1'b0;
      4'b0100: n1109 = 1'b0;
      4'b0010: n1109 = n1059;
      4'b0001: n1109 = n1015;
      default: n1109 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:10 */
  assign n1111 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:23 */
  assign n1113 = n1111 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:37 */
  assign n1114 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:31 */
  assign n1115 = n1114 & n1113;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:56 */
  assign n1117 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:67 */
  assign n1118 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:70 */
  assign n1119 = ~n1118;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:62 */
  assign n1120 = n1117 | n1119;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:47 */
  assign n1121 = n1120 & n1115;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:227:12 */
  assign n1123 = ir == 8'b11101011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:227:7 */
  assign n1126 = n1123 ? 4'b0001 : 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:226:5 */
  assign n1127 = n1121 ? n1126 : n1094;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:12 */
  assign n1128 = ir[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:247:15 */
  assign n1130 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:251:15 */
  assign n1132 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:256:15 */
  assign n1134 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:261:15 */
  assign n1136 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:264:15 */
  assign n1138 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:267:15 */
  assign n1140 = mcycle == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  assign n1141 = {n1140, n1138, n1136, n1134, n1132, n1130};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  always @*
    case (n1141)
      6'b100000: n1148 = 2'b00;
      6'b010000: n1148 = 2'b11;
      6'b001000: n1148 = 2'b11;
      6'b000100: n1148 = 2'b01;
      6'b000010: n1148 = 2'b01;
      6'b000001: n1148 = 2'b01;
      default: n1148 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  always @*
    case (n1141)
      6'b100000: n1152 = n1097;
      6'b010000: n1152 = n1097;
      6'b001000: n1152 = n1097;
      6'b000100: n1152 = 4'b0101;
      6'b000010: n1152 = 4'b0110;
      6'b000001: n1152 = 4'b0111;
      default: n1152 = n1097;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  always @*
    case (n1141)
      6'b100000: n1155 = 2'b10;
      6'b010000: n1155 = 2'b00;
      6'b001000: n1155 = 2'b00;
      6'b000100: n1155 = 2'b00;
      6'b000010: n1155 = 2'b00;
      6'b000001: n1155 = 2'b00;
      default: n1155 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  always @*
    case (n1141)
      6'b100000: n1160 = 1'b0;
      6'b010000: n1160 = 1'b0;
      6'b001000: n1160 = 1'b1;
      6'b000100: n1160 = 1'b1;
      6'b000010: n1160 = 1'b1;
      6'b000001: n1160 = 1'b0;
      default: n1160 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  always @*
    case (n1141)
      6'b100000: n1163 = 1'b0;
      6'b010000: n1163 = 1'b1;
      6'b001000: n1163 = 1'b0;
      6'b000100: n1163 = 1'b0;
      6'b000010: n1163 = 1'b0;
      6'b000001: n1163 = 1'b0;
      default: n1163 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:246:13 */
  always @*
    case (n1141)
      6'b100000: n1168 = 1'b0;
      6'b010000: n1168 = 1'b0;
      6'b001000: n1168 = 1'b0;
      6'b000100: n1168 = 1'b1;
      6'b000010: n1168 = 1'b1;
      6'b000001: n1168 = 1'b1;
      default: n1168 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:243:11 */
  assign n1170 = ir == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:274:15 */
  assign n1172 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:278:15 */
  assign n1174 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:282:15 */
  assign n1176 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:287:15 */
  assign n1178 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:289:15 */
  assign n1180 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  assign n1181 = {n1180, n1178, n1176, n1174, n1172};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  always @*
    case (n1181)
      5'b10000: n1186 = 2'b00;
      5'b01000: n1186 = 2'b00;
      5'b00100: n1186 = 2'b01;
      5'b00010: n1186 = 2'b01;
      5'b00001: n1186 = 2'b01;
      default: n1186 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  always @*
    case (n1181)
      5'b10000: n1189 = n1097;
      5'b01000: n1189 = n1097;
      5'b00100: n1189 = 4'b0110;
      5'b00010: n1189 = 4'b0111;
      5'b00001: n1189 = n1097;
      default: n1189 = n1097;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  always @*
    case (n1181)
      5'b10000: n1193 = 2'b10;
      5'b01000: n1193 = 2'b00;
      5'b00100: n1193 = 2'b00;
      5'b00010: n1193 = 2'b00;
      5'b00001: n1193 = 2'b01;
      default: n1193 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  always @*
    case (n1181)
      5'b10000: n1197 = 1'b0;
      5'b01000: n1197 = 1'b1;
      5'b00100: n1197 = 1'b1;
      5'b00010: n1197 = 1'b0;
      5'b00001: n1197 = 1'b0;
      default: n1197 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  always @*
    case (n1181)
      5'b10000: n1200 = 1'b0;
      5'b01000: n1200 = 1'b0;
      5'b00100: n1200 = 1'b0;
      5'b00010: n1200 = 1'b0;
      5'b00001: n1200 = 1'b1;
      default: n1200 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:273:13 */
  always @*
    case (n1181)
      5'b10000: n1204 = 1'b0;
      5'b01000: n1204 = 1'b0;
      5'b00100: n1204 = 1'b1;
      5'b00010: n1204 = 1'b1;
      5'b00001: n1204 = 1'b0;
      default: n1204 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:271:11 */
  assign n1206 = ir == 8'b00100000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:296:15 */
  assign n1208 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:298:15 */
  assign n1210 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:301:15 */
  assign n1212 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:305:15 */
  assign n1214 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:310:15 */
  assign n1216 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  assign n1217 = {n1216, n1214, n1212, n1210, n1208};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  always @*
    case (n1217)
      5'b10000: n1219 = n1127;
      5'b01000: n1219 = n1127;
      5'b00100: n1219 = 4'b0000;
      5'b00010: n1219 = n1127;
      5'b00001: n1219 = n1127;
      default: n1219 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  always @*
    case (n1217)
      5'b10000: n1225 = 2'b00;
      5'b01000: n1225 = 2'b01;
      5'b00100: n1225 = 2'b01;
      5'b00010: n1225 = 2'b01;
      5'b00001: n1225 = 2'b01;
      default: n1225 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  always @*
    case (n1217)
      5'b10000: n1228 = 2'b10;
      5'b01000: n1228 = 2'b00;
      5'b00100: n1228 = 2'b00;
      5'b00010: n1228 = 2'b00;
      5'b00001: n1228 = 2'b00;
      default: n1228 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  always @*
    case (n1217)
      5'b10000: n1233 = 1'b0;
      5'b01000: n1233 = 1'b1;
      5'b00100: n1233 = 1'b1;
      5'b00010: n1233 = 1'b1;
      5'b00001: n1233 = 1'b0;
      default: n1233 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  always @*
    case (n1217)
      5'b10000: n1236 = 1'b0;
      5'b01000: n1236 = 1'b1;
      5'b00100: n1236 = 1'b0;
      5'b00010: n1236 = 1'b0;
      5'b00001: n1236 = 1'b0;
      default: n1236 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:295:15 */
  always @*
    case (n1217)
      5'b10000: n1239 = 1'b0;
      5'b01000: n1239 = 1'b1;
      5'b00100: n1239 = 1'b0;
      5'b00010: n1239 = 1'b0;
      5'b00001: n1239 = 1'b0;
      default: n1239 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:293:13 */
  assign n1241 = ir == 8'b01000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:317:15 */
  assign n1243 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:319:15 */
  assign n1245 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:322:15 */
  assign n1247 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:326:15 */
  assign n1249 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:328:15 */
  assign n1251 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:316:13 */
  assign n1252 = {n1251, n1249, n1247, n1245, n1243};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:316:13 */
  always @*
    case (n1252)
      5'b10000: n1257 = 2'b00;
      5'b01000: n1257 = 2'b00;
      5'b00100: n1257 = 2'b01;
      5'b00010: n1257 = 2'b01;
      5'b00001: n1257 = 2'b01;
      default: n1257 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:316:13 */
  always @*
    case (n1252)
      5'b10000: n1261 = 2'b01;
      5'b01000: n1261 = 2'b10;
      5'b00100: n1261 = 2'b00;
      5'b00010: n1261 = 2'b00;
      5'b00001: n1261 = 2'b00;
      default: n1261 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:316:13 */
  always @*
    case (n1252)
      5'b10000: n1265 = 1'b0;
      5'b01000: n1265 = 1'b0;
      5'b00100: n1265 = 1'b1;
      5'b00010: n1265 = 1'b1;
      5'b00001: n1265 = 1'b0;
      default: n1265 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:316:13 */
  always @*
    case (n1252)
      5'b10000: n1268 = 1'b0;
      5'b01000: n1268 = 1'b0;
      5'b00100: n1268 = 1'b1;
      5'b00010: n1268 = 1'b0;
      5'b00001: n1268 = 1'b0;
      default: n1268 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:314:11 */
  assign n1270 = ir == 8'b01100000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:334:23 */
  assign n1272 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:334:36 */
  assign n1273 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:334:30 */
  assign n1274 = n1273 & n1272;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:334:15 */
  assign n1277 = n1274 ? 3'b001 : 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:24 */
  assign n1280 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:36 */
  assign n1281 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:39 */
  assign n1282 = ~n1281;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:31 */
  assign n1283 = n1280 | n1282;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:341:26 */
  assign n1284 = ir[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:342:19 */
  assign n1286 = n1284 == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:344:19 */
  assign n1288 = n1284 == 4'b0100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:347:29 */
  assign n1290 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:347:21 */
  assign n1292 = n1290 ? 4'b0011 : n1097;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:347:21 */
  assign n1295 = n1290 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:346:19 */
  assign n1297 = n1284 == 4'b0101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:353:29 */
  assign n1299 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:353:21 */
  assign n1301 = n1299 ? 4'b0010 : n1097;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:353:21 */
  assign n1304 = n1299 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:352:19 */
  assign n1306 = n1284 == 4'b1101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:341:19 */
  assign n1307 = {n1306, n1297, n1288, n1286};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:341:19 */
  always @*
    case (n1307)
      4'b1000: n1310 = n1301;
      4'b0100: n1310 = n1292;
      4'b0010: n1310 = 4'b0001;
      4'b0001: n1310 = 4'b0101;
      default: n1310 = n1097;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:341:19 */
  always @*
    case (n1307)
      4'b1000: n1312 = n1304;
      4'b0100: n1312 = n1295;
      4'b0010: n1312 = 1'b1;
      4'b0001: n1312 = 1'b1;
      default: n1312 = 1'b1;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:17 */
  assign n1316 = n1283 ? 2'b01 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:17 */
  assign n1317 = n1283 ? n1310 : n1097;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:339:17 */
  assign n1319 = n1283 ? n1312 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:338:15 */
  assign n1321 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:362:15 */
  assign n1323 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:337:15 */
  assign n1324 = {n1323, n1321};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:337:15 */
  always @*
    case (n1324)
      2'b10: n1326 = 2'b00;
      2'b01: n1326 = n1316;
      default: n1326 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:337:15 */
  always @*
    case (n1324)
      2'b10: n1327 = n1097;
      2'b01: n1327 = n1317;
      default: n1327 = n1097;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:337:15 */
  always @*
    case (n1324)
      2'b10: n1330 = 1'b1;
      2'b01: n1330 = 1'b0;
      default: n1330 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:337:15 */
  always @*
    case (n1324)
      2'b10: n1332 = 1'b0;
      2'b01: n1332 = n1319;
      default: n1332 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:13 */
  assign n1334 = ir == 8'b00001000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:24 */
  assign n1336 = ir == 8'b01001000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:24 */
  assign n1337 = n1334 | n1336;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:32 */
  assign n1339 = ir == 8'b01011010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:32 */
  assign n1340 = n1337 | n1339;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:40 */
  assign n1342 = ir == 8'b11011010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:332:40 */
  assign n1343 = n1340 | n1342;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:368:21 */
  assign n1345 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:368:34 */
  assign n1346 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:368:28 */
  assign n1347 = n1346 & n1345;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:368:13 */
  assign n1350 = n1347 ? 3'b001 : 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:371:20 */
  assign n1352 = ir[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:372:15 */
  assign n1354 = n1352 == 4'b0010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:374:15 */
  assign n1356 = n1352 == 4'b0110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:377:25 */
  assign n1358 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:377:17 */
  assign n1360 = n1358 ? 1'b1 : n1106;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:376:15 */
  assign n1362 = n1352 == 4'b0111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:381:25 */
  assign n1364 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:381:17 */
  assign n1366 = n1364 ? 1'b1 : n1103;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:380:15 */
  assign n1368 = n1352 == 4'b1111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:371:13 */
  assign n1369 = {n1368, n1362, n1356, n1354};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1369)
      4'b1000: n1371 = n1100;
      4'b0100: n1371 = n1100;
      4'b0010: n1371 = 1'b1;
      4'b0001: n1371 = n1100;
      default: n1371 = n1100;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1369)
      4'b1000: n1374 = 1'b0;
      4'b0100: n1374 = 1'b0;
      4'b0010: n1374 = 1'b0;
      4'b0001: n1374 = 1'b1;
      default: n1374 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1369)
      4'b1000: n1375 = n1366;
      4'b0100: n1375 = n1103;
      4'b0010: n1375 = n1103;
      4'b0001: n1375 = n1103;
      default: n1375 = n1103;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1369)
      4'b1000: n1376 = n1106;
      4'b0100: n1376 = n1360;
      4'b0010: n1376 = n1106;
      4'b0001: n1376 = n1106;
      default: n1376 = n1106;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:388:25 */
  assign n1378 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:388:38 */
  assign n1379 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:388:42 */
  assign n1380 = ~n1379;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:388:33 */
  assign n1381 = n1378 | n1380;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:388:17 */
  assign n1384 = n1381 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:387:15 */
  assign n1386 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:392:25 */
  assign n1388 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:392:38 */
  assign n1389 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:392:42 */
  assign n1390 = ~n1389;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:392:33 */
  assign n1391 = n1388 | n1390;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:392:17 */
  assign n1394 = n1391 ? 2'b01 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:392:17 */
  assign n1396 = n1391 ? 1'b0 : n1374;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:391:15 */
  assign n1398 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:396:15 */
  assign n1400 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:400:15 */
  assign n1402 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:386:13 */
  assign n1403 = {n1402, n1400, n1398, n1386};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:386:13 */
  always @*
    case (n1403)
      4'b1000: n1405 = 4'b0000;
      4'b0100: n1405 = n1127;
      4'b0010: n1405 = n1127;
      4'b0001: n1405 = n1127;
      default: n1405 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:386:13 */
  always @*
    case (n1403)
      4'b1000: n1408 = 2'b00;
      4'b0100: n1408 = 2'b01;
      4'b0010: n1408 = n1394;
      4'b0001: n1408 = 2'b00;
      default: n1408 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:386:13 */
  always @*
    case (n1403)
      4'b1000: n1411 = 1'b0;
      4'b0100: n1411 = 1'b1;
      4'b0010: n1411 = 1'b0;
      4'b0001: n1411 = 1'b0;
      default: n1411 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:386:13 */
  always @*
    case (n1403)
      4'b1000: n1413 = n1374;
      4'b0100: n1413 = 1'b0;
      4'b0010: n1413 = n1396;
      4'b0001: n1413 = n1374;
      default: n1413 = n1374;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:386:13 */
  always @*
    case (n1403)
      4'b1000: n1415 = 1'b0;
      4'b0100: n1415 = 1'b0;
      4'b0010: n1415 = 1'b0;
      4'b0001: n1415 = n1384;
      default: n1415 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:11 */
  assign n1417 = ir == 8'b00101000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:23 */
  assign n1419 = ir == 8'b01101000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:23 */
  assign n1420 = n1417 | n1419;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:31 */
  assign n1422 = ir == 8'b01111010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:31 */
  assign n1423 = n1420 | n1422;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:39 */
  assign n1425 = ir == 8'b11111010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:366:39 */
  assign n1426 = n1423 | n1425;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:407:15 */
  assign n1428 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:408:15 */
  assign n1430 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:406:13 */
  assign n1431 = {n1430, n1428};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:406:13 */
  always @*
    case (n1431)
      2'b10: n1434 = 2'b01;
      2'b01: n1434 = 2'b00;
      default: n1434 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:404:11 */
  assign n1436 = ir == 8'b10100000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:404:22 */
  assign n1438 = ir == 8'b11000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:404:22 */
  assign n1439 = n1436 | n1438;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:404:30 */
  assign n1441 = ir == 8'b11100000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:404:30 */
  assign n1442 = n1439 | n1441;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:415:15 */
  assign n1444 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:416:15 */
  assign n1446 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:414:13 */
  assign n1447 = {n1446, n1444};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:414:13 */
  always @*
    case (n1447)
      2'b10: n1449 = 4'b0011;
      2'b01: n1449 = n1127;
      default: n1449 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:412:11 */
  assign n1451 = ir == 8'b10001000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:423:15 */
  assign n1453 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:424:15 */
  assign n1455 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:422:13 */
  assign n1456 = {n1455, n1453};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:422:13 */
  always @*
    case (n1456)
      2'b10: n1458 = 4'b0010;
      2'b01: n1458 = n1127;
      default: n1458 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:420:11 */
  assign n1460 = ir == 8'b11001010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:429:21 */
  assign n1462 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:429:13 */
  assign n1464 = n1462 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:435:15 */
  assign n1466 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:436:15 */
  assign n1468 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:434:13 */
  assign n1469 = {n1468, n1466};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:434:13 */
  always @*
    case (n1469)
      2'b10: n1471 = 4'b0100;
      2'b01: n1471 = n1127;
      default: n1471 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:428:11 */
  assign n1473 = ir == 8'b00011010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:428:22 */
  assign n1475 = ir == 8'b00111010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:428:22 */
  assign n1476 = n1473 | n1475;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:11 */
  assign n1483 = ir == 8'b00001010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:22 */
  assign n1485 = ir == 8'b00101010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:22 */
  assign n1486 = n1483 | n1485;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:30 */
  assign n1488 = ir == 8'b01001010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:30 */
  assign n1489 = n1486 | n1488;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:38 */
  assign n1491 = ir == 8'b01101010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:440:38 */
  assign n1492 = n1489 | n1491;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:448:11 */
  assign n1499 = ir == 8'b10001010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:448:22 */
  assign n1501 = ir == 8'b10011000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:448:22 */
  assign n1502 = n1499 | n1501;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:457:15 */
  assign n1504 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:458:15 */
  assign n1506 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:456:13 */
  assign n1507 = {n1506, n1504};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:456:13 */
  always @*
    case (n1507)
      2'b10: n1509 = 4'b0001;
      2'b01: n1509 = n1127;
      default: n1509 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:455:11 */
  assign n1511 = ir == 8'b10101010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:455:22 */
  assign n1513 = ir == 8'b10101000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:455:22 */
  assign n1514 = n1511 | n1513;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:462:11 */
  assign n1516 = ir == 8'b10011010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:467:15 */
  assign n1518 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:468:15 */
  assign n1520 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:466:13 */
  assign n1521 = {n1520, n1518};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:466:13 */
  always @*
    case (n1521)
      2'b10: n1523 = 4'b0100;
      2'b01: n1523 = n1127;
      default: n1523 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:464:11 */
  assign n1525 = ir == 8'b10111010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:474:15 */
  assign n1527 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:475:15 */
  assign n1529 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:473:13 */
  assign n1530 = {n1529, n1527};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:473:13 */
  always @*
    case (n1530)
      2'b10: n1533 = 2'b01;
      2'b01: n1533 = 2'b00;
      default: n1533 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:472:11 */
  assign n1535 = ir == 8'b10000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  assign n1538 = {n1535, n1525, n1516, n1514, n1502, n1492, n1476, n1460, n1451, n1442, n1426, n1343, n1270, n1241, n1206, n1170};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1544 = 3'b001;
      16'b0100000000000000: n1544 = 3'b001;
      16'b0010000000000000: n1544 = 3'b001;
      16'b0001000000000000: n1544 = 3'b001;
      16'b0000100000000000: n1544 = 3'b001;
      16'b0000010000000000: n1544 = 3'b001;
      16'b0000001000000000: n1544 = 3'b001;
      16'b0000000100000000: n1544 = 3'b001;
      16'b0000000010000000: n1544 = 3'b001;
      16'b0000000001000000: n1544 = 3'b001;
      16'b0000000000100000: n1544 = n1350;
      16'b0000000000010000: n1544 = n1277;
      16'b0000000000001000: n1544 = 3'b101;
      16'b0000000000000100: n1544 = 3'b101;
      16'b0000000000000010: n1544 = 3'b101;
      16'b0000000000000001: n1544 = 3'b110;
      default: n1544 = 3'b001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1546 = n1127;
      16'b0100000000000000: n1546 = n1523;
      16'b0010000000000000: n1546 = n1127;
      16'b0001000000000000: n1546 = n1509;
      16'b0000100000000000: n1546 = n1127;
      16'b0000010000000000: n1546 = 4'b0001;
      16'b0000001000000000: n1546 = n1471;
      16'b0000000100000000: n1546 = n1458;
      16'b0000000010000000: n1546 = n1449;
      16'b0000000001000000: n1546 = n1127;
      16'b0000000000100000: n1546 = n1405;
      16'b0000000000010000: n1546 = n1127;
      16'b0000000000001000: n1546 = n1127;
      16'b0000000000000100: n1546 = n1219;
      16'b0000000000000010: n1546 = n1127;
      16'b0000000000000001: n1546 = n1127;
      default: n1546 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1548 = 2'b00;
      16'b0100000000000000: n1548 = 2'b00;
      16'b0010000000000000: n1548 = 2'b00;
      16'b0001000000000000: n1548 = 2'b00;
      16'b0000100000000000: n1548 = 2'b00;
      16'b0000010000000000: n1548 = 2'b00;
      16'b0000001000000000: n1548 = 2'b00;
      16'b0000000100000000: n1548 = 2'b00;
      16'b0000000010000000: n1548 = 2'b00;
      16'b0000000001000000: n1548 = 2'b00;
      16'b0000000000100000: n1548 = n1408;
      16'b0000000000010000: n1548 = n1326;
      16'b0000000000001000: n1548 = n1257;
      16'b0000000000000100: n1548 = n1225;
      16'b0000000000000010: n1548 = n1186;
      16'b0000000000000001: n1548 = n1148;
      default: n1548 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1549 = n1097;
      16'b0100000000000000: n1549 = n1097;
      16'b0010000000000000: n1549 = n1097;
      16'b0001000000000000: n1549 = n1097;
      16'b0000100000000000: n1549 = n1097;
      16'b0000010000000000: n1549 = n1097;
      16'b0000001000000000: n1549 = n1097;
      16'b0000000100000000: n1549 = n1097;
      16'b0000000010000000: n1549 = n1097;
      16'b0000000001000000: n1549 = n1097;
      16'b0000000000100000: n1549 = n1097;
      16'b0000000000010000: n1549 = n1327;
      16'b0000000000001000: n1549 = n1097;
      16'b0000000000000100: n1549 = n1097;
      16'b0000000000000010: n1549 = n1189;
      16'b0000000000000001: n1549 = n1152;
      default: n1549 = n1097;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1551 = n1533;
      16'b0100000000000000: n1551 = 2'b00;
      16'b0010000000000000: n1551 = 2'b00;
      16'b0001000000000000: n1551 = 2'b00;
      16'b0000100000000000: n1551 = 2'b00;
      16'b0000010000000000: n1551 = 2'b00;
      16'b0000001000000000: n1551 = 2'b00;
      16'b0000000100000000: n1551 = 2'b00;
      16'b0000000010000000: n1551 = 2'b00;
      16'b0000000001000000: n1551 = n1434;
      16'b0000000000100000: n1551 = 2'b00;
      16'b0000000000010000: n1551 = 2'b00;
      16'b0000000000001000: n1551 = n1261;
      16'b0000000000000100: n1551 = n1228;
      16'b0000000000000010: n1551 = n1193;
      16'b0000000000000001: n1551 = n1155;
      default: n1551 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1553 = 1'b0;
      16'b0100000000000000: n1553 = 1'b0;
      16'b0010000000000000: n1553 = 1'b0;
      16'b0001000000000000: n1553 = 1'b0;
      16'b0000100000000000: n1553 = 1'b0;
      16'b0000010000000000: n1553 = 1'b0;
      16'b0000001000000000: n1553 = 1'b0;
      16'b0000000100000000: n1553 = 1'b0;
      16'b0000000010000000: n1553 = 1'b0;
      16'b0000000001000000: n1553 = 1'b0;
      16'b0000000000100000: n1553 = n1411;
      16'b0000000000010000: n1553 = 1'b0;
      16'b0000000000001000: n1553 = n1265;
      16'b0000000000000100: n1553 = n1233;
      16'b0000000000000010: n1553 = 1'b0;
      16'b0000000000000001: n1553 = 1'b0;
      default: n1553 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1555 = 1'b0;
      16'b0100000000000000: n1555 = 1'b0;
      16'b0010000000000000: n1555 = 1'b0;
      16'b0001000000000000: n1555 = 1'b0;
      16'b0000100000000000: n1555 = 1'b0;
      16'b0000010000000000: n1555 = 1'b0;
      16'b0000001000000000: n1555 = 1'b0;
      16'b0000000100000000: n1555 = 1'b0;
      16'b0000000010000000: n1555 = 1'b0;
      16'b0000000001000000: n1555 = 1'b0;
      16'b0000000000100000: n1555 = 1'b0;
      16'b0000000000010000: n1555 = n1330;
      16'b0000000000001000: n1555 = 1'b0;
      16'b0000000000000100: n1555 = 1'b0;
      16'b0000000000000010: n1555 = n1197;
      16'b0000000000000001: n1555 = n1160;
      default: n1555 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1558 = n1100;
      16'b0100000000000000: n1558 = n1100;
      16'b0010000000000000: n1558 = n1100;
      16'b0001000000000000: n1558 = n1100;
      16'b0000100000000000: n1558 = 1'b1;
      16'b0000010000000000: n1558 = 1'b1;
      16'b0000001000000000: n1558 = n1464;
      16'b0000000100000000: n1558 = n1100;
      16'b0000000010000000: n1558 = n1100;
      16'b0000000001000000: n1558 = n1100;
      16'b0000000000100000: n1558 = n1371;
      16'b0000000000010000: n1558 = n1100;
      16'b0000000000001000: n1558 = n1100;
      16'b0000000000000100: n1558 = n1100;
      16'b0000000000000010: n1558 = n1100;
      16'b0000000000000001: n1558 = n1100;
      default: n1558 = n1100;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1560 = 1'b0;
      16'b0100000000000000: n1560 = 1'b0;
      16'b0010000000000000: n1560 = 1'b0;
      16'b0001000000000000: n1560 = 1'b0;
      16'b0000100000000000: n1560 = 1'b0;
      16'b0000010000000000: n1560 = 1'b0;
      16'b0000001000000000: n1560 = 1'b0;
      16'b0000000100000000: n1560 = 1'b0;
      16'b0000000010000000: n1560 = 1'b0;
      16'b0000000001000000: n1560 = 1'b0;
      16'b0000000000100000: n1560 = n1413;
      16'b0000000000010000: n1560 = 1'b0;
      16'b0000000000001000: n1560 = 1'b0;
      16'b0000000000000100: n1560 = n1236;
      16'b0000000000000010: n1560 = 1'b0;
      16'b0000000000000001: n1560 = 1'b0;
      default: n1560 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1563 = n1103;
      16'b0100000000000000: n1563 = 1'b1;
      16'b0010000000000000: n1563 = n1103;
      16'b0001000000000000: n1563 = n1103;
      16'b0000100000000000: n1563 = n1103;
      16'b0000010000000000: n1563 = n1103;
      16'b0000001000000000: n1563 = n1103;
      16'b0000000100000000: n1563 = 1'b1;
      16'b0000000010000000: n1563 = n1103;
      16'b0000000001000000: n1563 = n1103;
      16'b0000000000100000: n1563 = n1375;
      16'b0000000000010000: n1563 = n1103;
      16'b0000000000001000: n1563 = n1103;
      16'b0000000000000100: n1563 = n1103;
      16'b0000000000000010: n1563 = n1103;
      16'b0000000000000001: n1563 = n1103;
      default: n1563 = n1103;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1565 = n1106;
      16'b0100000000000000: n1565 = n1106;
      16'b0010000000000000: n1565 = n1106;
      16'b0001000000000000: n1565 = n1106;
      16'b0000100000000000: n1565 = n1106;
      16'b0000010000000000: n1565 = n1106;
      16'b0000001000000000: n1565 = n1106;
      16'b0000000100000000: n1565 = n1106;
      16'b0000000010000000: n1565 = 1'b1;
      16'b0000000001000000: n1565 = n1106;
      16'b0000000000100000: n1565 = n1376;
      16'b0000000000010000: n1565 = n1106;
      16'b0000000000001000: n1565 = n1106;
      16'b0000000000000100: n1565 = n1106;
      16'b0000000000000010: n1565 = n1106;
      16'b0000000000000001: n1565 = n1106;
      default: n1565 = n1106;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1567 = n1109;
      16'b0100000000000000: n1567 = n1109;
      16'b0010000000000000: n1567 = 1'b1;
      16'b0001000000000000: n1567 = n1109;
      16'b0000100000000000: n1567 = n1109;
      16'b0000010000000000: n1567 = n1109;
      16'b0000001000000000: n1567 = n1109;
      16'b0000000100000000: n1567 = n1109;
      16'b0000000010000000: n1567 = n1109;
      16'b0000000001000000: n1567 = n1109;
      16'b0000000000100000: n1567 = n1109;
      16'b0000000000010000: n1567 = n1109;
      16'b0000000000001000: n1567 = n1109;
      16'b0000000000000100: n1567 = n1109;
      16'b0000000000000010: n1567 = n1109;
      16'b0000000000000001: n1567 = n1109;
      default: n1567 = n1109;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1569 = 1'b0;
      16'b0100000000000000: n1569 = 1'b0;
      16'b0010000000000000: n1569 = 1'b0;
      16'b0001000000000000: n1569 = 1'b0;
      16'b0000100000000000: n1569 = 1'b0;
      16'b0000010000000000: n1569 = 1'b0;
      16'b0000001000000000: n1569 = 1'b0;
      16'b0000000100000000: n1569 = 1'b0;
      16'b0000000010000000: n1569 = 1'b0;
      16'b0000000001000000: n1569 = 1'b0;
      16'b0000000000100000: n1569 = 1'b0;
      16'b0000000000010000: n1569 = 1'b0;
      16'b0000000000001000: n1569 = n1268;
      16'b0000000000000100: n1569 = n1239;
      16'b0000000000000010: n1569 = n1200;
      16'b0000000000000001: n1569 = n1163;
      default: n1569 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1571 = 1'b0;
      16'b0100000000000000: n1571 = 1'b0;
      16'b0010000000000000: n1571 = 1'b0;
      16'b0001000000000000: n1571 = 1'b0;
      16'b0000100000000000: n1571 = 1'b0;
      16'b0000010000000000: n1571 = 1'b0;
      16'b0000001000000000: n1571 = 1'b0;
      16'b0000000100000000: n1571 = 1'b0;
      16'b0000000010000000: n1571 = 1'b0;
      16'b0000000001000000: n1571 = 1'b0;
      16'b0000000000100000: n1571 = n1415;
      16'b0000000000010000: n1571 = 1'b0;
      16'b0000000000001000: n1571 = 1'b0;
      16'b0000000000000100: n1571 = 1'b0;
      16'b0000000000000010: n1571 = 1'b0;
      16'b0000000000000001: n1571 = 1'b0;
      default: n1571 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:242:9 */
  always @*
    case (n1538)
      16'b1000000000000000: n1573 = 1'b0;
      16'b0100000000000000: n1573 = 1'b0;
      16'b0010000000000000: n1573 = 1'b0;
      16'b0001000000000000: n1573 = 1'b0;
      16'b0000100000000000: n1573 = 1'b0;
      16'b0000010000000000: n1573 = 1'b0;
      16'b0000001000000000: n1573 = 1'b0;
      16'b0000000100000000: n1573 = 1'b0;
      16'b0000000010000000: n1573 = 1'b0;
      16'b0000000001000000: n1573 = 1'b0;
      16'b0000000000100000: n1573 = 1'b0;
      16'b0000000000010000: n1573 = n1332;
      16'b0000000000001000: n1573 = 1'b0;
      16'b0000000000000100: n1573 = 1'b0;
      16'b0000000000000010: n1573 = n1204;
      16'b0000000000000001: n1573 = n1168;
      default: n1573 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:7 */
  assign n1575 = n1128 == 5'b00000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:20 */
  assign n1577 = n1128 == 5'b01000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:20 */
  assign n1578 = n1575 | n1577;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:30 */
  assign n1580 = n1128 == 5'b01010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:30 */
  assign n1581 = n1578 | n1580;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:40 */
  assign n1583 = n1128 == 5'b11000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:40 */
  assign n1584 = n1581 | n1583;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:50 */
  assign n1586 = n1128 == 5'b11010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:240:50 */
  assign n1587 = n1584 | n1586;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:491:14 */
  assign n1588 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:491:27 */
  assign n1590 = n1588 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:493:18 */
  assign n1592 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:493:30 */
  assign n1593 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:493:24 */
  assign n1594 = n1593 & n1592;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:493:11 */
  assign n1597 = n1594 ? 3'b111 : 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:491:9 */
  assign n1599 = n1590 ? n1597 : 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:491:9 */
  assign n1602 = n1590 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:498:11 */
  assign n1604 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:502:11 */
  assign n1606 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:505:11 */
  assign n1608 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:511:18 */
  assign n1609 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:511:31 */
  assign n1611 = n1609 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:511:13 */
  assign n1614 = n1611 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:509:11 */
  assign n1616 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:20 */
  assign n1618 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:32 */
  assign n1619 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:26 */
  assign n1620 = n1619 & n1618;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:46 */
  assign n1621 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:58 */
  assign n1623 = n1621 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:40 */
  assign n1624 = n1623 & n1620;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:13 */
  assign n1627 = n1624 ? 2'b11 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:13 */
  assign n1630 = n1624 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:516:13 */
  assign n1633 = n1624 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:515:11 */
  assign n1635 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:521:11 */
  assign n1637 = mcycle == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:526:11 */
  assign n1639 = mcycle == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  assign n1640 = {n1639, n1637, n1635, n1616, n1608, n1606, n1604};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1642 = 4'b0001;
      7'b0100000: n1642 = n1127;
      7'b0010000: n1642 = n1127;
      7'b0001000: n1642 = n1127;
      7'b0000100: n1642 = n1127;
      7'b0000010: n1642 = n1127;
      7'b0000001: n1642 = n1127;
      default: n1642 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1649 = 2'b00;
      7'b0100000: n1649 = 2'b11;
      7'b0010000: n1649 = n1627;
      7'b0001000: n1649 = 2'b11;
      7'b0000100: n1649 = 2'b10;
      7'b0000010: n1649 = 2'b10;
      7'b0000001: n1649 = 2'b10;
      default: n1649 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1652 = 2'b00;
      7'b0100000: n1652 = 2'b00;
      7'b0010000: n1652 = 2'b00;
      7'b0001000: n1652 = 2'b00;
      7'b0000100: n1652 = 2'b00;
      7'b0000010: n1652 = 2'b00;
      7'b0000001: n1652 = 2'b01;
      default: n1652 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1655 = 2'b00;
      7'b0100000: n1655 = 2'b00;
      7'b0010000: n1655 = 2'b00;
      7'b0001000: n1655 = 2'b00;
      7'b0000100: n1655 = 2'b01;
      7'b0000010: n1655 = 2'b00;
      7'b0000001: n1655 = 2'b00;
      default: n1655 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1658 = 1'b0;
      7'b0100000: n1658 = 1'b0;
      7'b0010000: n1658 = 1'b0;
      7'b0001000: n1658 = 1'b0;
      7'b0000100: n1658 = 1'b0;
      7'b0000010: n1658 = 1'b1;
      7'b0000001: n1658 = 1'b0;
      default: n1658 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1660 = 1'b0;
      7'b0100000: n1660 = 1'b0;
      7'b0010000: n1660 = n1630;
      7'b0001000: n1660 = 1'b0;
      7'b0000100: n1660 = 1'b0;
      7'b0000010: n1660 = 1'b0;
      7'b0000001: n1660 = 1'b0;
      default: n1660 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1663 = 1'b0;
      7'b0100000: n1663 = 1'b1;
      7'b0010000: n1663 = 1'b0;
      7'b0001000: n1663 = 1'b0;
      7'b0000100: n1663 = 1'b0;
      7'b0000010: n1663 = 1'b0;
      7'b0000001: n1663 = 1'b0;
      default: n1663 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1666 = 1'b0;
      7'b0100000: n1666 = 1'b0;
      7'b0010000: n1666 = 1'b0;
      7'b0001000: n1666 = 1'b0;
      7'b0000100: n1666 = 1'b0;
      7'b0000010: n1666 = 1'b0;
      7'b0000001: n1666 = 1'b1;
      default: n1666 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1669 = 1'b0;
      7'b0100000: n1669 = 1'b0;
      7'b0010000: n1669 = 1'b0;
      7'b0001000: n1669 = 1'b0;
      7'b0000100: n1669 = 1'b1;
      7'b0000010: n1669 = 1'b0;
      7'b0000001: n1669 = 1'b0;
      default: n1669 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1672 = 1'b0;
      7'b0100000: n1672 = 1'b0;
      7'b0010000: n1672 = 1'b0;
      7'b0001000: n1672 = 1'b1;
      7'b0000100: n1672 = 1'b0;
      7'b0000010: n1672 = 1'b0;
      7'b0000001: n1672 = 1'b0;
      default: n1672 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1675 = 1'b0;
      7'b0100000: n1675 = 1'b1;
      7'b0010000: n1675 = 1'b0;
      7'b0001000: n1675 = 1'b0;
      7'b0000100: n1675 = 1'b0;
      7'b0000010: n1675 = 1'b0;
      7'b0000001: n1675 = 1'b0;
      default: n1675 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1678 = 1'b0;
      7'b0100000: n1678 = 1'b1;
      7'b0010000: n1678 = n1633;
      7'b0001000: n1678 = n1614;
      7'b0000100: n1678 = 1'b0;
      7'b0000010: n1678 = 1'b0;
      7'b0000001: n1678 = 1'b0;
      default: n1678 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:497:9 */
  always @*
    case (n1640)
      7'b1000000: n1681 = 1'b1;
      7'b0100000: n1681 = 1'b0;
      7'b0010000: n1681 = 1'b0;
      7'b0001000: n1681 = 1'b0;
      7'b0000100: n1681 = 1'b0;
      7'b0000010: n1681 = 1'b0;
      7'b0000001: n1681 = 1'b0;
      default: n1681 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:488:7 */
  assign n1683 = n1128 == 5'b00001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:488:20 */
  assign n1685 = n1128 == 5'b00011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:488:20 */
  assign n1686 = n1683 | n1685;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:535:14 */
  assign n1687 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:535:26 */
  assign n1689 = n1687 != 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:535:9 */
  assign n1691 = n1689 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:539:11 */
  assign n1693 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:538:9 */
  always @*
    case (n1693)
      1'b1: n1696 = 2'b01;
      default: n1696 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:533:7 */
  assign n1698 = n1128 == 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:546:16 */
  assign n1700 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:548:18 */
  assign n1701 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:13 */
  assign n1703 = n1701 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:23 */
  assign n1705 = n1701 == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:23 */
  assign n1706 = n1703 | n1705;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:29 */
  assign n1708 = n1701 == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:29 */
  assign n1709 = n1706 | n1708;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:35 */
  assign n1711 = n1701 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:549:35 */
  assign n1712 = n1709 | n1711;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:552:13 */
  assign n1714 = n1701 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:555:13 */
  assign n1716 = n1701 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:558:13 */
  assign n1718 = n1701 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:548:11 */
  assign n1719 = {n1718, n1716, n1714, n1712};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:548:11 */
  always @*
    case (n1719)
      4'b1000: n1724 = 4'b0111;
      4'b0100: n1724 = 4'b1001;
      4'b0010: n1724 = 4'b1000;
      4'b0001: n1724 = 4'b0110;
      default: n1724 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:548:11 */
  always @*
    case (n1719)
      4'b1000: n1729 = 1'b1;
      4'b0100: n1729 = n1100;
      4'b0010: n1729 = 1'b1;
      4'b0001: n1729 = 1'b1;
      default: n1729 = 1'b1;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:548:11 */
  always @*
    case (n1719)
      4'b1000: n1731 = n1103;
      4'b0100: n1731 = 1'b1;
      4'b0010: n1731 = n1103;
      4'b0001: n1731 = n1103;
      default: n1731 = n1103;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:565:13 */
  assign n1733 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:564:11 */
  always @*
    case (n1733)
      1'b1: n1736 = 2'b01;
      default: n1736 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:546:9 */
  assign n1737 = n1700 ? n1724 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:546:9 */
  assign n1739 = n1700 ? n1736 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:546:9 */
  assign n1740 = n1700 ? n1729 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:546:9 */
  assign n1741 = n1700 ? n1731 : n1103;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:545:7 */
  assign n1743 = n1128 == 5'b01011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:576:11 */
  assign n1745 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:578:19 */
  assign n1747 = ir == 8'b10100010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:21 */
  assign n1748 = ir[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:33 */
  assign n1750 = n1748 == 4'b1000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:46 */
  assign n1751 = ir[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:58 */
  assign n1753 = n1751 == 4'b1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:41 */
  assign n1754 = n1750 | n1753;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:71 */
  assign n1755 = ir[7:4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:83 */
  assign n1757 = n1755 == 4'b1110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:66 */
  assign n1758 = n1754 | n1757;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:582:13 */
  assign n1761 = n1758 ? 2'b01 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:578:13 */
  assign n1763 = n1747 ? 2'b01 : n1761;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:578:13 */
  assign n1765 = n1747 ? 1'b1 : n1103;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:577:11 */
  assign n1767 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:575:9 */
  assign n1768 = {n1767, n1745};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:575:9 */
  always @*
    case (n1768)
      2'b10: n1770 = n1763;
      2'b01: n1770 = 2'b00;
      default: n1770 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:575:9 */
  always @*
    case (n1768)
      2'b10: n1771 = n1765;
      2'b01: n1771 = n1103;
      default: n1771 = n1103;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:573:7 */
  assign n1773 = n1128 == 5'b00010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:573:20 */
  assign n1775 = n1128 == 5'b10010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:573:20 */
  assign n1776 = n1773 | n1775;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:597:18 */
  assign n1777 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:597:31 */
  assign n1779 = n1777 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:597:13 */
  assign n1782 = n1779 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:596:11 */
  assign n1784 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:603:18 */
  assign n1785 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:603:31 */
  assign n1787 = n1785 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:603:13 */
  assign n1790 = n1787 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:600:11 */
  assign n1792 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:607:11 */
  assign n1794 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:595:9 */
  assign n1795 = {n1794, n1792, n1784};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:595:9 */
  always @*
    case (n1795)
      3'b100: n1798 = 2'b00;
      3'b010: n1798 = 2'b10;
      3'b001: n1798 = 2'b00;
      default: n1798 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:595:9 */
  always @*
    case (n1795)
      3'b100: n1801 = 2'b00;
      3'b010: n1801 = 2'b01;
      3'b001: n1801 = 2'b00;
      default: n1801 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:595:9 */
  always @*
    case (n1795)
      3'b100: n1804 = 1'b0;
      3'b010: n1804 = 1'b1;
      3'b001: n1804 = 1'b0;
      default: n1804 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:595:9 */
  always @*
    case (n1795)
      3'b100: n1806 = 1'b0;
      3'b010: n1806 = 1'b0;
      3'b001: n1806 = n1782;
      default: n1806 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:595:9 */
  always @*
    case (n1795)
      3'b100: n1808 = 1'b0;
      3'b010: n1808 = n1790;
      3'b001: n1808 = 1'b0;
      default: n1808 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:592:7 */
  assign n1810 = n1128 == 5'b00100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:14 */
  assign n1811 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:27 */
  assign n1813 = n1811 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:41 */
  assign n1814 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:35 */
  assign n1815 = n1814 & n1813;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:60 */
  assign n1817 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:71 */
  assign n1818 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:74 */
  assign n1819 = ~n1818;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:66 */
  assign n1820 = n1817 | n1819;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:51 */
  assign n1821 = n1820 & n1815;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:619:18 */
  assign n1823 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:619:30 */
  assign n1824 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:619:24 */
  assign n1825 = n1824 & n1823;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:619:11 */
  assign n1827 = n1825 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:623:13 */
  assign n1829 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:629:22 */
  assign n1831 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:629:15 */
  assign n1834 = n1831 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:627:13 */
  assign n1836 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:633:13 */
  assign n1838 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:639:22 */
  assign n1840 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:639:34 */
  assign n1841 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:639:28 */
  assign n1842 = n1841 & n1840;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:639:15 */
  assign n1844 = n1842 ? 4'b0001 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:639:15 */
  assign n1847 = n1842 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:639:15 */
  assign n1850 = n1842 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:638:13 */
  assign n1852 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  assign n1853 = {n1852, n1838, n1836, n1829};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1854 = n1844;
      4'b0100: n1854 = n1127;
      4'b0010: n1854 = n1127;
      4'b0001: n1854 = n1127;
      default: n1854 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1859 = 2'b00;
      4'b0100: n1859 = 2'b10;
      4'b0010: n1859 = 2'b10;
      4'b0001: n1859 = 2'b10;
      default: n1859 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1862 = 2'b00;
      4'b0100: n1862 = 2'b00;
      4'b0010: n1862 = 2'b00;
      4'b0001: n1862 = 2'b01;
      default: n1862 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1865 = n1847;
      4'b0100: n1865 = 1'b0;
      4'b0010: n1865 = 1'b1;
      4'b0001: n1865 = 1'b0;
      default: n1865 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1868 = 1'b0;
      4'b0100: n1868 = 1'b1;
      4'b0010: n1868 = 1'b0;
      4'b0001: n1868 = 1'b0;
      default: n1868 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1871 = 1'b0;
      4'b0100: n1871 = 1'b0;
      4'b0010: n1871 = 1'b0;
      4'b0001: n1871 = 1'b1;
      default: n1871 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1874 = 1'b0;
      4'b0100: n1874 = 1'b1;
      4'b0010: n1874 = 1'b0;
      4'b0001: n1874 = 1'b0;
      default: n1874 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1877 = 1'b0;
      4'b0100: n1877 = 1'b1;
      4'b0010: n1877 = n1834;
      4'b0001: n1877 = 1'b0;
      default: n1877 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:622:11 */
  always @*
    case (n1853)
      4'b1000: n1879 = n1850;
      4'b0100: n1879 = 1'b0;
      4'b0010: n1879 = 1'b0;
      4'b0001: n1879 = 1'b0;
      default: n1879 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:648:16 */
  assign n1880 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:648:29 */
  assign n1882 = n1880 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:648:11 */
  assign n1884 = n1882 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:652:13 */
  assign n1886 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:656:20 */
  assign n1887 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:656:33 */
  assign n1889 = n1887 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:656:15 */
  assign n1892 = n1889 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:653:13 */
  assign n1894 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:660:13 */
  assign n1896 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:651:11 */
  assign n1897 = {n1896, n1894, n1886};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:651:11 */
  always @*
    case (n1897)
      3'b100: n1900 = 2'b00;
      3'b010: n1900 = 2'b10;
      3'b001: n1900 = 2'b00;
      default: n1900 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:651:11 */
  always @*
    case (n1897)
      3'b100: n1903 = 2'b00;
      3'b010: n1903 = 2'b01;
      3'b001: n1903 = 2'b00;
      default: n1903 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:651:11 */
  always @*
    case (n1897)
      3'b100: n1906 = 1'b0;
      3'b010: n1906 = 1'b1;
      3'b001: n1906 = 1'b0;
      default: n1906 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:651:11 */
  always @*
    case (n1897)
      3'b100: n1908 = 1'b0;
      3'b010: n1908 = n1892;
      3'b001: n1908 = 1'b0;
      default: n1908 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1911 = n1821 ? 3'b100 : 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1912 = n1821 ? n1854 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1913 = n1821 ? n1859 : n1900;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1914 = n1821 ? n1862 : n1903;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1915 = n1821 ? n1827 : n1884;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1917 = n1821 ? n1865 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1919 = n1821 ? n1868 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1920 = n1821 ? n1871 : n1906;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1922 = n1821 ? n1874 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1923 = n1821 ? n1877 : n1908;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:616:9 */
  assign n1925 = n1821 ? n1879 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:614:7 */
  assign n1927 = n1128 == 5'b00101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:614:20 */
  assign n1929 = n1128 == 5'b00110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:614:20 */
  assign n1930 = n1927 | n1929;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:614:30 */
  assign n1932 = n1128 == 5'b00111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:614:30 */
  assign n1933 = n1930 | n1932;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:14 */
  assign n1934 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:27 */
  assign n1936 = n1934 == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:40 */
  assign n1937 = ir[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:53 */
  assign n1939 = n1937 == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:34 */
  assign n1940 = n1939 & n1936;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:16 */
  assign n1941 = ir[5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:20 */
  assign n1942 = ~n1941;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:672:15 */
  assign n1944 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:675:15 */
  assign n1946 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:671:13 */
  assign n1947 = {n1946, n1944};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:671:13 */
  always @*
    case (n1947)
      2'b10: n1951 = 2'b10;
      2'b01: n1951 = 2'b01;
      default: n1951 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:671:13 */
  always @*
    case (n1947)
      2'b10: n1954 = 1'b0;
      2'b01: n1954 = 1'b1;
      default: n1954 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:682:15 */
  assign n1956 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:688:25 */
  assign n1958 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:688:17 */
  assign n1961 = n1958 ? 2'b10 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:691:25 */
  assign n1963 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:691:17 */
  assign n1966 = n1963 ? 2'b11 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:686:15 */
  assign n1968 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:696:25 */
  assign n1970 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:696:17 */
  assign n1973 = n1970 ? 2'b11 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:696:17 */
  assign n1976 = n1970 ? 2'b00 : 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:696:17 */
  assign n1979 = n1970 ? 2'b01 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:694:15 */
  assign n1981 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:702:15 */
  assign n1983 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  assign n1984 = {n1983, n1981, n1968, n1956};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  always @*
    case (n1984)
      4'b1000: n1986 = 2'b00;
      4'b0100: n1986 = n1973;
      4'b0010: n1986 = n1966;
      4'b0001: n1986 = 2'b00;
      default: n1986 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  always @*
    case (n1984)
      4'b1000: n1990 = 2'b10;
      4'b0100: n1990 = n1976;
      4'b0010: n1990 = n1961;
      4'b0001: n1990 = 2'b01;
      default: n1990 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  always @*
    case (n1984)
      4'b1000: n1992 = 2'b00;
      4'b0100: n1992 = n1979;
      4'b0010: n1992 = 2'b00;
      4'b0001: n1992 = 2'b00;
      default: n1992 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  always @*
    case (n1984)
      4'b1000: n1996 = 1'b0;
      4'b0100: n1996 = 1'b1;
      4'b0010: n1996 = 1'b0;
      4'b0001: n1996 = 1'b1;
      default: n1996 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  always @*
    case (n1984)
      4'b1000: n1999 = 1'b0;
      4'b0100: n1999 = 1'b0;
      4'b0010: n1999 = 1'b0;
      4'b0001: n1999 = 1'b1;
      default: n1999 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:681:13 */
  always @*
    case (n1984)
      4'b1000: n2002 = 1'b0;
      4'b0100: n2002 = 1'b0;
      4'b0010: n2002 = 1'b1;
      4'b0001: n2002 = 1'b0;
      default: n2002 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2005 = n1942 ? 3'b010 : 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2007 = n1942 ? 2'b00 : n1986;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2008 = n1942 ? n1951 : n1990;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2010 = n1942 ? 2'b00 : n1992;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2011 = n1942 ? n1954 : n1996;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2013 = n1942 ? 1'b0 : n1999;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:669:11 */
  assign n2015 = n1942 ? 1'b0 : n2002;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:711:20 */
  assign n2016 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:711:33 */
  assign n2018 = n2016 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:711:15 */
  assign n2021 = n2018 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:710:13 */
  assign n2023 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:714:13 */
  assign n2025 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:720:20 */
  assign n2026 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:720:33 */
  assign n2028 = n2026 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:720:15 */
  assign n2031 = n2028 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:717:13 */
  assign n2033 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:724:13 */
  assign n2035 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  assign n2036 = {n2035, n2033, n2025, n2023};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  always @*
    case (n2036)
      4'b1000: n2039 = 2'b00;
      4'b0100: n2039 = 2'b11;
      4'b0010: n2039 = 2'b00;
      4'b0001: n2039 = 2'b00;
      default: n2039 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  always @*
    case (n2036)
      4'b1000: n2043 = 2'b00;
      4'b0100: n2043 = 2'b01;
      4'b0010: n2043 = 2'b01;
      4'b0001: n2043 = 2'b00;
      default: n2043 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  always @*
    case (n2036)
      4'b1000: n2046 = 1'b0;
      4'b0100: n2046 = 1'b0;
      4'b0010: n2046 = 1'b1;
      4'b0001: n2046 = 1'b0;
      default: n2046 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  always @*
    case (n2036)
      4'b1000: n2049 = 1'b0;
      4'b0100: n2049 = 1'b1;
      4'b0010: n2049 = 1'b0;
      4'b0001: n2049 = 1'b0;
      default: n2049 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  always @*
    case (n2036)
      4'b1000: n2051 = 1'b0;
      4'b0100: n2051 = 1'b0;
      4'b0010: n2051 = 1'b0;
      4'b0001: n2051 = n2021;
      default: n2051 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:709:11 */
  always @*
    case (n2036)
      4'b1000: n2053 = 1'b0;
      4'b0100: n2053 = n2031;
      4'b0010: n2053 = 1'b0;
      4'b0001: n2053 = 1'b0;
      default: n2053 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2055 = n1940 ? n2005 : 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2056 = n1940 ? n2007 : n2039;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2057 = n1940 ? n2008 : n2043;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2059 = n1940 ? n2010 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2061 = n1940 ? n2011 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2062 = n1940 ? n2013 : n2046;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2063 = n1940 ? n2015 : n2049;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2065 = n1940 ? 1'b0 : n2051;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:668:9 */
  assign n2067 = n1940 ? 1'b0 : n2053;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:666:7 */
  assign n2069 = n1128 == 5'b01100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:14 */
  assign n2070 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:27 */
  assign n2072 = n2070 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:41 */
  assign n2073 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:35 */
  assign n2074 = n2073 & n2072;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:60 */
  assign n2076 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:71 */
  assign n2077 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:74 */
  assign n2078 = ~n2077;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:66 */
  assign n2079 = n2076 | n2078;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:51 */
  assign n2080 = n2079 & n2074;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:737:18 */
  assign n2082 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:737:30 */
  assign n2083 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:737:24 */
  assign n2084 = n2083 & n2082;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:737:11 */
  assign n2086 = n2084 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:741:13 */
  assign n2088 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:744:13 */
  assign n2090 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:750:22 */
  assign n2092 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:750:15 */
  assign n2095 = n2092 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:748:13 */
  assign n2097 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:754:13 */
  assign n2099 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:760:22 */
  assign n2101 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:760:34 */
  assign n2102 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:760:28 */
  assign n2103 = n2102 & n2101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:760:15 */
  assign n2105 = n2103 ? 4'b0001 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:760:15 */
  assign n2108 = n2103 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:759:13 */
  assign n2110 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  assign n2111 = {n2110, n2099, n2097, n2090, n2088};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2112 = n2105;
      5'b01000: n2112 = n1127;
      5'b00100: n2112 = n1127;
      5'b00010: n2112 = n1127;
      5'b00001: n2112 = n1127;
      default: n2112 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2117 = 2'b00;
      5'b01000: n2117 = 2'b11;
      5'b00100: n2117 = 2'b11;
      5'b00010: n2117 = 2'b11;
      5'b00001: n2117 = 2'b00;
      default: n2117 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2121 = 2'b00;
      5'b01000: n2121 = 2'b00;
      5'b00100: n2121 = 2'b00;
      5'b00010: n2121 = 2'b01;
      5'b00001: n2121 = 2'b01;
      default: n2121 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2124 = 1'b0;
      5'b01000: n2124 = 1'b0;
      5'b00100: n2124 = 1'b1;
      5'b00010: n2124 = 1'b0;
      5'b00001: n2124 = 1'b0;
      default: n2124 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2127 = 1'b0;
      5'b01000: n2127 = 1'b1;
      5'b00100: n2127 = 1'b0;
      5'b00010: n2127 = 1'b0;
      5'b00001: n2127 = 1'b0;
      default: n2127 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2130 = 1'b0;
      5'b01000: n2130 = 1'b0;
      5'b00100: n2130 = 1'b0;
      5'b00010: n2130 = 1'b0;
      5'b00001: n2130 = 1'b1;
      default: n2130 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2133 = 1'b0;
      5'b01000: n2133 = 1'b0;
      5'b00100: n2133 = 1'b0;
      5'b00010: n2133 = 1'b1;
      5'b00001: n2133 = 1'b0;
      default: n2133 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2136 = 1'b0;
      5'b01000: n2136 = 1'b1;
      5'b00100: n2136 = 1'b0;
      5'b00010: n2136 = 1'b0;
      5'b00001: n2136 = 1'b0;
      default: n2136 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2139 = 1'b0;
      5'b01000: n2139 = 1'b1;
      5'b00100: n2139 = n2095;
      5'b00010: n2139 = 1'b0;
      5'b00001: n2139 = 1'b0;
      default: n2139 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:740:11 */
  always @*
    case (n2111)
      5'b10000: n2141 = n2108;
      5'b01000: n2141 = 1'b0;
      5'b00100: n2141 = 1'b0;
      5'b00010: n2141 = 1'b0;
      5'b00001: n2141 = 1'b0;
      default: n2141 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:768:16 */
  assign n2142 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:768:29 */
  assign n2144 = n2142 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:768:11 */
  assign n2146 = n2144 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:772:13 */
  assign n2148 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:773:13 */
  assign n2150 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:779:20 */
  assign n2151 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:779:33 */
  assign n2153 = n2151 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:779:15 */
  assign n2156 = n2153 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:776:13 */
  assign n2158 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:783:13 */
  assign n2160 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:771:11 */
  assign n2161 = {n2160, n2158, n2150, n2148};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:771:11 */
  always @*
    case (n2161)
      4'b1000: n2164 = 2'b00;
      4'b0100: n2164 = 2'b11;
      4'b0010: n2164 = 2'b00;
      4'b0001: n2164 = 2'b00;
      default: n2164 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:771:11 */
  always @*
    case (n2161)
      4'b1000: n2168 = 2'b00;
      4'b0100: n2168 = 2'b01;
      4'b0010: n2168 = 2'b01;
      4'b0001: n2168 = 2'b00;
      default: n2168 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:771:11 */
  always @*
    case (n2161)
      4'b1000: n2171 = 1'b0;
      4'b0100: n2171 = 1'b0;
      4'b0010: n2171 = 1'b1;
      4'b0001: n2171 = 1'b0;
      default: n2171 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:771:11 */
  always @*
    case (n2161)
      4'b1000: n2174 = 1'b0;
      4'b0100: n2174 = 1'b1;
      4'b0010: n2174 = 1'b0;
      4'b0001: n2174 = 1'b0;
      default: n2174 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:771:11 */
  always @*
    case (n2161)
      4'b1000: n2176 = 1'b0;
      4'b0100: n2176 = n2156;
      4'b0010: n2176 = 1'b0;
      4'b0001: n2176 = 1'b0;
      default: n2176 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2179 = n2080 ? 3'b101 : 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2180 = n2080 ? n2112 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2181 = n2080 ? n2117 : n2164;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2182 = n2080 ? n2121 : n2168;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2183 = n2080 ? n2086 : n2146;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2185 = n2080 ? n2124 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2187 = n2080 ? n2127 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2188 = n2080 ? n2130 : n2171;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2189 = n2080 ? n2133 : n2174;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2191 = n2080 ? n2136 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2192 = n2080 ? n2139 : n2176;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:734:9 */
  assign n2194 = n2080 ? n2141 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:732:7 */
  assign n2196 = n1128 == 5'b01101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:732:20 */
  assign n2198 = n1128 == 5'b01110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:732:20 */
  assign n2199 = n2196 | n2198;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:732:30 */
  assign n2201 = n1128 == 5'b01111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:732:30 */
  assign n2202 = n2199 | n2201;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:795:9 */
  assign n2205 = branch ? 3'b011 : 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:809:11 */
  assign n2207 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:820:11 */
  assign n2209 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:829:11 */
  assign n2211 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:804:9 */
  assign n2212 = {n2211, n2209, n2207};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:804:9 */
  always @*
    case (n2212)
      3'b100: n2216 = 2'b00;
      3'b010: n2216 = 2'b11;
      3'b001: n2216 = 2'b01;
      default: n2216 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:804:9 */
  always @*
    case (n2212)
      3'b100: n2219 = 1'b0;
      3'b010: n2219 = 1'b1;
      3'b001: n2219 = 1'b0;
      default: n2219 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:804:9 */
  always @*
    case (n2212)
      3'b100: n2222 = 1'b0;
      3'b010: n2222 = 1'b0;
      3'b001: n2222 = 1'b1;
      default: n2222 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:789:7 */
  assign n2224 = n1128 == 5'b10000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:837:14 */
  assign n2225 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:837:27 */
  assign n2227 = n2225 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:839:18 */
  assign n2229 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:839:30 */
  assign n2230 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:839:24 */
  assign n2231 = n2230 & n2229;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:839:11 */
  assign n2234 = n2231 ? 3'b111 : 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:837:9 */
  assign n2236 = n2227 ? n2234 : 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:837:9 */
  assign n2239 = n2227 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:844:11 */
  assign n2241 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:848:11 */
  assign n2243 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:852:11 */
  assign n2245 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:859:18 */
  assign n2246 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:859:31 */
  assign n2248 = n2246 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:861:20 */
  assign n2249 = ir[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:861:33 */
  assign n2251 = n2249 == 4'b0011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:861:15 */
  assign n2254 = n2251 ? 2'b10 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:864:21 */
  assign n2255 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:864:24 */
  assign n2256 = ~n2255;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:864:34 */
  assign n2258 = ir == 8'b10110011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:864:29 */
  assign n2259 = n2256 | n2258;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:864:13 */
  assign n2262 = n2259 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:859:13 */
  assign n2264 = n2248 ? n2254 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:859:13 */
  assign n2266 = n2248 ? 1'b0 : n2262;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:859:13 */
  assign n2269 = n2248 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:857:11 */
  assign n2271 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:20 */
  assign n2273 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:32 */
  assign n2274 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:26 */
  assign n2275 = n2274 & n2273;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:46 */
  assign n2276 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:58 */
  assign n2278 = n2276 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:40 */
  assign n2279 = n2278 & n2275;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:13 */
  assign n2282 = n2279 ? 2'b11 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:13 */
  assign n2285 = n2279 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:869:13 */
  assign n2288 = n2279 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:868:11 */
  assign n2290 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:874:11 */
  assign n2292 = mcycle == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:879:11 */
  assign n2294 = mcycle == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  assign n2295 = {n2294, n2292, n2290, n2271, n2245, n2243, n2241};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2298 = 4'b0001;
      7'b0100000: n2298 = n1127;
      7'b0010000: n2298 = n1127;
      7'b0001000: n2298 = n1127;
      7'b0000100: n2298 = 4'b0011;
      7'b0000010: n2298 = n1127;
      7'b0000001: n2298 = n1127;
      default: n2298 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2305 = 2'b00;
      7'b0100000: n2305 = 2'b11;
      7'b0010000: n2305 = n2282;
      7'b0001000: n2305 = 2'b11;
      7'b0000100: n2305 = 2'b11;
      7'b0000010: n2305 = 2'b10;
      7'b0000001: n2305 = 2'b10;
      default: n2305 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2308 = 2'b00;
      7'b0100000: n2308 = 2'b00;
      7'b0010000: n2308 = 2'b00;
      7'b0001000: n2308 = 2'b00;
      7'b0000100: n2308 = 2'b00;
      7'b0000010: n2308 = 2'b00;
      7'b0000001: n2308 = 2'b01;
      default: n2308 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2313 = 2'b00;
      7'b0100000: n2313 = 2'b00;
      7'b0010000: n2313 = 2'b00;
      7'b0001000: n2313 = 2'b11;
      7'b0000100: n2313 = 2'b10;
      7'b0000010: n2313 = 2'b01;
      7'b0000001: n2313 = 2'b00;
      default: n2313 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2315 = 2'b00;
      7'b0100000: n2315 = 2'b00;
      7'b0010000: n2315 = 2'b00;
      7'b0001000: n2315 = n2264;
      7'b0000100: n2315 = 2'b00;
      7'b0000010: n2315 = 2'b00;
      7'b0000001: n2315 = 2'b00;
      default: n2315 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2317 = 1'b0;
      7'b0100000: n2317 = 1'b0;
      7'b0010000: n2317 = 1'b0;
      7'b0001000: n2317 = n2266;
      7'b0000100: n2317 = 1'b0;
      7'b0000010: n2317 = 1'b0;
      7'b0000001: n2317 = 1'b0;
      default: n2317 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2319 = 1'b0;
      7'b0100000: n2319 = 1'b0;
      7'b0010000: n2319 = n2285;
      7'b0001000: n2319 = 1'b0;
      7'b0000100: n2319 = 1'b0;
      7'b0000010: n2319 = 1'b0;
      7'b0000001: n2319 = 1'b0;
      default: n2319 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2322 = 1'b0;
      7'b0100000: n2322 = 1'b1;
      7'b0010000: n2322 = 1'b0;
      7'b0001000: n2322 = 1'b0;
      7'b0000100: n2322 = 1'b0;
      7'b0000010: n2322 = 1'b0;
      7'b0000001: n2322 = 1'b0;
      default: n2322 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2325 = 1'b0;
      7'b0100000: n2325 = 1'b0;
      7'b0010000: n2325 = 1'b0;
      7'b0001000: n2325 = 1'b0;
      7'b0000100: n2325 = 1'b0;
      7'b0000010: n2325 = 1'b0;
      7'b0000001: n2325 = 1'b1;
      default: n2325 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2328 = 1'b0;
      7'b0100000: n2328 = 1'b0;
      7'b0010000: n2328 = 1'b0;
      7'b0001000: n2328 = 1'b0;
      7'b0000100: n2328 = 1'b0;
      7'b0000010: n2328 = 1'b1;
      7'b0000001: n2328 = 1'b0;
      default: n2328 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2331 = 1'b0;
      7'b0100000: n2331 = 1'b0;
      7'b0010000: n2331 = 1'b0;
      7'b0001000: n2331 = 1'b0;
      7'b0000100: n2331 = 1'b1;
      7'b0000010: n2331 = 1'b0;
      7'b0000001: n2331 = 1'b0;
      default: n2331 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2334 = 1'b0;
      7'b0100000: n2334 = 1'b1;
      7'b0010000: n2334 = 1'b0;
      7'b0001000: n2334 = 1'b0;
      7'b0000100: n2334 = 1'b0;
      7'b0000010: n2334 = 1'b0;
      7'b0000001: n2334 = 1'b0;
      default: n2334 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2337 = 1'b0;
      7'b0100000: n2337 = 1'b1;
      7'b0010000: n2337 = n2288;
      7'b0001000: n2337 = n2269;
      7'b0000100: n2337 = 1'b0;
      7'b0000010: n2337 = 1'b0;
      7'b0000001: n2337 = 1'b0;
      default: n2337 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:843:9 */
  always @*
    case (n2295)
      7'b1000000: n2340 = 1'b1;
      7'b0100000: n2340 = 1'b0;
      7'b0010000: n2340 = 1'b0;
      7'b0001000: n2340 = 1'b0;
      7'b0000100: n2340 = 1'b0;
      7'b0000010: n2340 = 1'b0;
      7'b0000001: n2340 = 1'b0;
      default: n2340 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:835:7 */
  assign n2342 = n1128 == 5'b10001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:835:20 */
  assign n2344 = n1128 == 5'b10011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:835:20 */
  assign n2345 = n2342 | n2344;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:14 */
  assign n2346 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:27 */
  assign n2348 = n2346 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:41 */
  assign n2349 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:35 */
  assign n2350 = n2349 & n2348;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:60 */
  assign n2352 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:71 */
  assign n2353 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:74 */
  assign n2354 = ~n2353;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:66 */
  assign n2355 = n2352 | n2354;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:51 */
  assign n2356 = n2355 & n2350;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:893:18 */
  assign n2358 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:893:30 */
  assign n2359 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:893:24 */
  assign n2360 = n2359 & n2358;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:893:11 */
  assign n2362 = n2360 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:898:13 */
  assign n2364 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:902:13 */
  assign n2366 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:907:22 */
  assign n2368 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:907:15 */
  assign n2371 = n2368 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:905:13 */
  assign n2373 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:916:22 */
  assign n2375 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:916:34 */
  assign n2376 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:916:28 */
  assign n2377 = n2376 & n2375;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:916:15 */
  assign n2380 = n2377 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:911:13 */
  assign n2382 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:920:22 */
  assign n2384 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:920:34 */
  assign n2385 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:920:28 */
  assign n2386 = n2385 & n2384;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:920:15 */
  assign n2388 = n2386 ? 4'b0001 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:920:15 */
  assign n2391 = n2386 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:919:13 */
  assign n2393 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  assign n2394 = {n2393, n2382, n2373, n2366, n2364};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2395 = n2388;
      5'b01000: n2395 = n1127;
      5'b00100: n2395 = n1127;
      5'b00010: n2395 = n1127;
      5'b00001: n2395 = n1127;
      default: n2395 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2401 = 2'b00;
      5'b01000: n2401 = 2'b10;
      5'b00100: n2401 = 2'b10;
      5'b00010: n2401 = 2'b10;
      5'b00001: n2401 = 2'b10;
      default: n2401 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2404 = 2'b00;
      5'b01000: n2404 = 2'b00;
      5'b00100: n2404 = 2'b00;
      5'b00010: n2404 = 2'b00;
      5'b00001: n2404 = 2'b01;
      default: n2404 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2407 = 1'b0;
      5'b01000: n2407 = 1'b0;
      5'b00100: n2407 = 1'b0;
      5'b00010: n2407 = 1'b1;
      5'b00001: n2407 = 1'b0;
      default: n2407 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2410 = 1'b0;
      5'b01000: n2410 = n2380;
      5'b00100: n2410 = 1'b1;
      5'b00010: n2410 = 1'b0;
      5'b00001: n2410 = 1'b0;
      default: n2410 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2413 = 1'b0;
      5'b01000: n2413 = 1'b1;
      5'b00100: n2413 = 1'b0;
      5'b00010: n2413 = 1'b0;
      5'b00001: n2413 = 1'b0;
      default: n2413 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2416 = 1'b0;
      5'b01000: n2416 = 1'b0;
      5'b00100: n2416 = 1'b0;
      5'b00010: n2416 = 1'b0;
      5'b00001: n2416 = 1'b1;
      default: n2416 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2419 = 1'b0;
      5'b01000: n2419 = 1'b1;
      5'b00100: n2419 = 1'b0;
      5'b00010: n2419 = 1'b0;
      5'b00001: n2419 = 1'b0;
      default: n2419 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2422 = 1'b0;
      5'b01000: n2422 = 1'b1;
      5'b00100: n2422 = n2371;
      5'b00010: n2422 = 1'b0;
      5'b00001: n2422 = 1'b0;
      default: n2422 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:897:11 */
  always @*
    case (n2394)
      5'b10000: n2424 = n2391;
      5'b01000: n2424 = 1'b0;
      5'b00100: n2424 = 1'b0;
      5'b00010: n2424 = 1'b0;
      5'b00001: n2424 = 1'b0;
      default: n2424 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:928:16 */
  assign n2425 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:928:29 */
  assign n2427 = n2425 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:928:43 */
  assign n2428 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:928:37 */
  assign n2429 = n2428 & n2427;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:928:11 */
  assign n2431 = n2429 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:932:13 */
  assign n2433 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:933:13 */
  assign n2435 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:940:21 */
  assign n2436 = ir[3:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:940:34 */
  assign n2438 = n2436 == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:940:15 */
  assign n2441 = n2438 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:943:20 */
  assign n2442 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:943:33 */
  assign n2444 = n2442 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:943:15 */
  assign n2447 = n2444 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:937:13 */
  assign n2449 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:947:13 */
  assign n2451 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  assign n2452 = {n2451, n2449, n2435, n2433};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  always @*
    case (n2452)
      4'b1000: n2456 = 2'b00;
      4'b0100: n2456 = 2'b10;
      4'b0010: n2456 = 2'b10;
      4'b0001: n2456 = 2'b00;
      default: n2456 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  always @*
    case (n2452)
      4'b1000: n2459 = 2'b00;
      4'b0100: n2459 = 2'b00;
      4'b0010: n2459 = 2'b01;
      4'b0001: n2459 = 2'b00;
      default: n2459 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  always @*
    case (n2452)
      4'b1000: n2462 = 1'b0;
      4'b0100: n2462 = 1'b1;
      4'b0010: n2462 = 1'b0;
      4'b0001: n2462 = 1'b0;
      default: n2462 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  always @*
    case (n2452)
      4'b1000: n2464 = 1'b0;
      4'b0100: n2464 = n2441;
      4'b0010: n2464 = 1'b0;
      4'b0001: n2464 = 1'b0;
      default: n2464 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  always @*
    case (n2452)
      4'b1000: n2467 = 1'b0;
      4'b0100: n2467 = 1'b0;
      4'b0010: n2467 = 1'b1;
      4'b0001: n2467 = 1'b0;
      default: n2467 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:931:11 */
  always @*
    case (n2452)
      4'b1000: n2469 = 1'b0;
      4'b0100: n2469 = n2447;
      4'b0010: n2469 = 1'b0;
      4'b0001: n2469 = 1'b0;
      default: n2469 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2472 = n2356 ? 3'b101 : 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2473 = n2356 ? n2395 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2474 = n2356 ? n2401 : n2456;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2475 = n2356 ? n2404 : n2459;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2476 = n2356 ? n2407 : n2462;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2478 = n2356 ? 1'b0 : n2464;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2479 = n2356 ? n2362 : n2431;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2481 = n2356 ? n2410 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2483 = n2356 ? n2413 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2484 = n2356 ? n2416 : n2467;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2486 = n2356 ? n2419 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2487 = n2356 ? n2422 : n2469;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:891:9 */
  assign n2489 = n2356 ? n2424 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:7 */
  assign n2491 = n1128 == 5'b10100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:20 */
  assign n2493 = n1128 == 5'b10101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:20 */
  assign n2494 = n2491 | n2493;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:30 */
  assign n2496 = n1128 == 5'b10110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:30 */
  assign n2497 = n2494 | n2496;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:40 */
  assign n2499 = n1128 == 5'b10111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:889:40 */
  assign n2500 = n2497 | n2499;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:957:14 */
  assign n2501 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:957:27 */
  assign n2503 = n2501 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:959:18 */
  assign n2505 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:959:30 */
  assign n2506 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:959:24 */
  assign n2507 = n2506 & n2505;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:959:11 */
  assign n2510 = n2507 ? 3'b110 : 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:957:9 */
  assign n2512 = n2503 ? n2510 : 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:957:9 */
  assign n2515 = n2503 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:964:11 */
  assign n2517 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:967:11 */
  assign n2519 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:975:18 */
  assign n2520 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:975:31 */
  assign n2522 = n2520 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:977:20 */
  assign n2523 = ir[3:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:977:33 */
  assign n2525 = n2523 == 4'b1011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:977:15 */
  assign n2528 = n2525 ? 2'b01 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:980:21 */
  assign n2529 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:980:24 */
  assign n2530 = ~n2529;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:980:34 */
  assign n2532 = ir == 8'b10111011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:980:29 */
  assign n2533 = n2530 | n2532;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:980:13 */
  assign n2536 = n2533 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:975:13 */
  assign n2538 = n2522 ? n2528 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:975:13 */
  assign n2540 = n2522 ? 1'b0 : n2536;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:975:13 */
  assign n2543 = n2522 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:973:11 */
  assign n2545 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:20 */
  assign n2547 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:32 */
  assign n2548 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:26 */
  assign n2549 = n2548 & n2547;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:46 */
  assign n2550 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:58 */
  assign n2552 = n2550 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:40 */
  assign n2553 = n2552 & n2549;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:13 */
  assign n2556 = n2553 ? 2'b11 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:13 */
  assign n2559 = n2553 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:985:13 */
  assign n2562 = n2553 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:984:11 */
  assign n2564 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:990:11 */
  assign n2566 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:995:11 */
  assign n2568 = mcycle == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  assign n2569 = {n2568, n2566, n2564, n2545, n2519, n2517};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2572 = 4'b0001;
      6'b010000: n2572 = n1127;
      6'b001000: n2572 = n1127;
      6'b000100: n2572 = n1127;
      6'b000010: n2572 = 4'b0011;
      6'b000001: n2572 = n1127;
      default: n2572 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2577 = 2'b00;
      6'b010000: n2577 = 2'b11;
      6'b001000: n2577 = n2556;
      6'b000100: n2577 = 2'b11;
      6'b000010: n2577 = 2'b11;
      6'b000001: n2577 = 2'b00;
      default: n2577 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2581 = 2'b00;
      6'b010000: n2581 = 2'b00;
      6'b001000: n2581 = 2'b00;
      6'b000100: n2581 = 2'b00;
      6'b000010: n2581 = 2'b01;
      6'b000001: n2581 = 2'b01;
      default: n2581 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2585 = 2'b00;
      6'b010000: n2585 = 2'b00;
      6'b001000: n2585 = 2'b00;
      6'b000100: n2585 = 2'b11;
      6'b000010: n2585 = 2'b10;
      6'b000001: n2585 = 2'b00;
      default: n2585 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2587 = 2'b00;
      6'b010000: n2587 = 2'b00;
      6'b001000: n2587 = 2'b00;
      6'b000100: n2587 = n2538;
      6'b000010: n2587 = 2'b00;
      6'b000001: n2587 = 2'b00;
      default: n2587 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2589 = 1'b0;
      6'b010000: n2589 = 1'b0;
      6'b001000: n2589 = 1'b0;
      6'b000100: n2589 = n2540;
      6'b000010: n2589 = 1'b0;
      6'b000001: n2589 = 1'b0;
      default: n2589 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2591 = 1'b0;
      6'b010000: n2591 = 1'b0;
      6'b001000: n2591 = n2559;
      6'b000100: n2591 = 1'b0;
      6'b000010: n2591 = 1'b0;
      6'b000001: n2591 = 1'b0;
      default: n2591 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2594 = 1'b0;
      6'b010000: n2594 = 1'b1;
      6'b001000: n2594 = 1'b0;
      6'b000100: n2594 = 1'b0;
      6'b000010: n2594 = 1'b0;
      6'b000001: n2594 = 1'b0;
      default: n2594 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2597 = 1'b0;
      6'b010000: n2597 = 1'b0;
      6'b001000: n2597 = 1'b0;
      6'b000100: n2597 = 1'b0;
      6'b000010: n2597 = 1'b0;
      6'b000001: n2597 = 1'b1;
      default: n2597 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2600 = 1'b0;
      6'b010000: n2600 = 1'b0;
      6'b001000: n2600 = 1'b0;
      6'b000100: n2600 = 1'b0;
      6'b000010: n2600 = 1'b1;
      6'b000001: n2600 = 1'b0;
      default: n2600 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2603 = 1'b0;
      6'b010000: n2603 = 1'b1;
      6'b001000: n2603 = 1'b0;
      6'b000100: n2603 = 1'b0;
      6'b000010: n2603 = 1'b0;
      6'b000001: n2603 = 1'b0;
      default: n2603 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2606 = 1'b0;
      6'b010000: n2606 = 1'b1;
      6'b001000: n2606 = n2562;
      6'b000100: n2606 = n2543;
      6'b000010: n2606 = 1'b0;
      6'b000001: n2606 = 1'b0;
      default: n2606 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:963:9 */
  always @*
    case (n2569)
      6'b100000: n2609 = 1'b1;
      6'b010000: n2609 = 1'b0;
      6'b001000: n2609 = 1'b0;
      6'b000100: n2609 = 1'b0;
      6'b000010: n2609 = 1'b0;
      6'b000001: n2609 = 1'b0;
      default: n2609 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:954:7 */
  assign n2611 = n1128 == 5'b11001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:954:20 */
  assign n2613 = n1128 == 5'b11011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:954:20 */
  assign n2614 = n2611 | n2613;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:14 */
  assign n2615 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:27 */
  assign n2617 = n2615 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:41 */
  assign n2618 = ir[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:35 */
  assign n2619 = n2618 & n2617;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:60 */
  assign n2621 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:71 */
  assign n2622 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:74 */
  assign n2623 = ~n2622;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:66 */
  assign n2624 = n2621 | n2623;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:51 */
  assign n2625 = n2624 & n2619;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1010:18 */
  assign n2627 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1010:30 */
  assign n2628 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1010:24 */
  assign n2629 = n2628 & n2627;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1010:11 */
  assign n2631 = n2629 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1014:13 */
  assign n2633 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1017:13 */
  assign n2635 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1023:13 */
  assign n2637 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1028:22 */
  assign n2639 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1028:15 */
  assign n2642 = n2639 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1026:13 */
  assign n2644 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1032:13 */
  assign n2646 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1038:22 */
  assign n2648 = mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1038:34 */
  assign n2649 = ir[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1038:28 */
  assign n2650 = n2649 & n2648;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1038:15 */
  assign n2652 = n2650 ? 4'b0001 : n1127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1038:15 */
  assign n2655 = n2650 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1037:13 */
  assign n2657 = mcycle == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  assign n2658 = {n2657, n2646, n2644, n2637, n2635, n2633};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2660 = n2652;
      6'b010000: n2660 = n1127;
      6'b001000: n2660 = n1127;
      6'b000100: n2660 = n1127;
      6'b000010: n2660 = 4'b0010;
      6'b000001: n2660 = n1127;
      default: n2660 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2666 = 2'b00;
      6'b010000: n2666 = 2'b11;
      6'b001000: n2666 = 2'b11;
      6'b000100: n2666 = 2'b11;
      6'b000010: n2666 = 2'b11;
      6'b000001: n2666 = 2'b00;
      default: n2666 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2670 = 2'b00;
      6'b010000: n2670 = 2'b00;
      6'b001000: n2670 = 2'b00;
      6'b000100: n2670 = 2'b00;
      6'b000010: n2670 = 2'b01;
      6'b000001: n2670 = 2'b01;
      default: n2670 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2674 = 2'b00;
      6'b010000: n2674 = 2'b00;
      6'b001000: n2674 = 2'b00;
      6'b000100: n2674 = 2'b11;
      6'b000010: n2674 = 2'b10;
      6'b000001: n2674 = 2'b00;
      default: n2674 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2677 = 1'b0;
      6'b010000: n2677 = 1'b0;
      6'b001000: n2677 = 1'b1;
      6'b000100: n2677 = 1'b0;
      6'b000010: n2677 = 1'b0;
      6'b000001: n2677 = 1'b0;
      default: n2677 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2680 = 1'b0;
      6'b010000: n2680 = 1'b1;
      6'b001000: n2680 = 1'b0;
      6'b000100: n2680 = 1'b0;
      6'b000010: n2680 = 1'b0;
      6'b000001: n2680 = 1'b0;
      default: n2680 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2683 = 1'b0;
      6'b010000: n2683 = 1'b0;
      6'b001000: n2683 = 1'b0;
      6'b000100: n2683 = 1'b0;
      6'b000010: n2683 = 1'b0;
      6'b000001: n2683 = 1'b1;
      default: n2683 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2686 = 1'b0;
      6'b010000: n2686 = 1'b0;
      6'b001000: n2686 = 1'b0;
      6'b000100: n2686 = 1'b0;
      6'b000010: n2686 = 1'b1;
      6'b000001: n2686 = 1'b0;
      default: n2686 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2689 = 1'b0;
      6'b010000: n2689 = 1'b1;
      6'b001000: n2689 = 1'b0;
      6'b000100: n2689 = 1'b0;
      6'b000010: n2689 = 1'b0;
      6'b000001: n2689 = 1'b0;
      default: n2689 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2692 = 1'b0;
      6'b010000: n2692 = 1'b1;
      6'b001000: n2692 = n2642;
      6'b000100: n2692 = 1'b0;
      6'b000010: n2692 = 1'b0;
      6'b000001: n2692 = 1'b0;
      default: n2692 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1013:11 */
  always @*
    case (n2658)
      6'b100000: n2694 = n2655;
      6'b010000: n2694 = 1'b0;
      6'b001000: n2694 = 1'b0;
      6'b000100: n2694 = 1'b0;
      6'b000010: n2694 = 1'b0;
      6'b000001: n2694 = 1'b0;
      default: n2694 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1046:16 */
  assign n2695 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1046:29 */
  assign n2697 = n2695 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:20 */
  assign n2699 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:32 */
  assign n2700 = ir[4]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:35 */
  assign n2701 = ~n2700;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:27 */
  assign n2702 = n2699 | n2701;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:45 */
  assign n2703 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:57 */
  assign n2705 = n2703 != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1047:40 */
  assign n2706 = n2702 | n2705;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1046:11 */
  assign n2708 = n2709 ? 1'b1 : n1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1046:11 */
  assign n2709 = n2706 & n2697;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1052:13 */
  assign n2711 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1053:13 */
  assign n2713 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1059:20 */
  assign n2714 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1059:32 */
  assign n2716 = n2714 == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1059:44 */
  assign n2717 = ir[4:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1059:56 */
  assign n2719 = n2717 == 4'b1111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1059:38 */
  assign n2720 = n2719 & n2716;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1059:15 */
  assign n2723 = n2720 ? 4'b0011 : 4'b0010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1056:13 */
  assign n2725 = mcycle == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1069:20 */
  assign n2726 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1069:33 */
  assign n2728 = n2726 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1071:24 */
  assign n2729 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1072:17 */
  assign n2731 = n2729 == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1072:26 */
  assign n2733 = n2729 == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1072:26 */
  assign n2734 = n2731 | n2733;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1073:17 */
  assign n2736 = n2729 == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1071:17 */
  assign n2737 = {n2736, n2734};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1071:17 */
  always @*
    case (n2737)
      2'b10: n2741 = 2'b10;
      2'b01: n2741 = 2'b01;
      default: n2741 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1069:15 */
  assign n2743 = n2728 ? n2741 : 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1069:15 */
  assign n2746 = n2728 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1069:15 */
  assign n2749 = n2728 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1067:13 */
  assign n2751 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1080:13 */
  assign n2753 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  assign n2754 = {n2753, n2751, n2725, n2713, n2711};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2755 = n1127;
      5'b01000: n2755 = n1127;
      5'b00100: n2755 = n2723;
      5'b00010: n2755 = n1127;
      5'b00001: n2755 = n1127;
      default: n2755 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2759 = 2'b00;
      5'b01000: n2759 = 2'b11;
      5'b00100: n2759 = 2'b11;
      5'b00010: n2759 = 2'b00;
      5'b00001: n2759 = 2'b00;
      default: n2759 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2763 = 2'b00;
      5'b01000: n2763 = 2'b00;
      5'b00100: n2763 = 2'b01;
      5'b00010: n2763 = 2'b01;
      5'b00001: n2763 = 2'b00;
      default: n2763 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2767 = 2'b00;
      5'b01000: n2767 = 2'b11;
      5'b00100: n2767 = 2'b10;
      5'b00010: n2767 = 2'b00;
      5'b00001: n2767 = 2'b00;
      default: n2767 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2769 = 2'b00;
      5'b01000: n2769 = n2743;
      5'b00100: n2769 = 2'b00;
      5'b00010: n2769 = 2'b00;
      5'b00001: n2769 = 2'b00;
      default: n2769 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2771 = 1'b0;
      5'b01000: n2771 = n2746;
      5'b00100: n2771 = 1'b0;
      5'b00010: n2771 = 1'b0;
      5'b00001: n2771 = 1'b0;
      default: n2771 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2774 = 1'b0;
      5'b01000: n2774 = 1'b0;
      5'b00100: n2774 = 1'b0;
      5'b00010: n2774 = 1'b1;
      5'b00001: n2774 = 1'b0;
      default: n2774 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2777 = 1'b0;
      5'b01000: n2777 = 1'b0;
      5'b00100: n2777 = 1'b1;
      5'b00010: n2777 = 1'b0;
      5'b00001: n2777 = 1'b0;
      default: n2777 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1051:11 */
  always @*
    case (n2754)
      5'b10000: n2779 = 1'b0;
      5'b01000: n2779 = n2749;
      5'b00100: n2779 = 1'b0;
      5'b00010: n2779 = 1'b0;
      5'b00001: n2779 = 1'b0;
      default: n2779 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2782 = n2625 ? 3'b110 : 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2783 = n2625 ? n2660 : n2755;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2784 = n2625 ? n2666 : n2759;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2785 = n2625 ? n2670 : n2763;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2786 = n2625 ? n2674 : n2767;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2788 = n2625 ? 2'b00 : n2769;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2790 = n2625 ? 1'b0 : n2771;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2791 = n2625 ? n2631 : n2708;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2793 = n2625 ? n2677 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2795 = n2625 ? n2680 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2796 = n2625 ? n2683 : n2774;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2797 = n2625 ? n2686 : n2777;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2799 = n2625 ? n2689 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2800 = n2625 ? n2692 : n2779;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1007:9 */
  assign n2802 = n2625 ? n2694 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:7 */
  assign n2804 = n1128 == 5'b11100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:20 */
  assign n2806 = n1128 == 5'b11101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:20 */
  assign n2807 = n2804 | n2806;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:30 */
  assign n2809 = n1128 == 5'b11110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:30 */
  assign n2810 = n2807 | n2809;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:40 */
  assign n2812 = n1128 == 5'b11111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1005:40 */
  assign n2813 = n2810 | n2812;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  assign n2814 = {n2813, n2614, n2500, n2345, n2224, n2202, n2069, n1933, n1810, n1776, n1743, n1698, n1686, n1587};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2817 = n2782;
      14'b01000000000000: n2817 = n2512;
      14'b00100000000000: n2817 = n2472;
      14'b00010000000000: n2817 = n2236;
      14'b00001000000000: n2817 = n2205;
      14'b00000100000000: n2817 = n2179;
      14'b00000010000000: n2817 = n2055;
      14'b00000001000000: n2817 = n1911;
      14'b00000000100000: n2817 = 3'b010;
      14'b00000000010000: n2817 = 3'b001;
      14'b00000000001000: n2817 = 3'b001;
      14'b00000000000100: n2817 = 3'b001;
      14'b00000000000010: n2817 = n1599;
      14'b00000000000001: n2817 = n1544;
      default: n2817 = 3'b001;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2819 = n2783;
      14'b01000000000000: n2819 = n2572;
      14'b00100000000000: n2819 = n2473;
      14'b00010000000000: n2819 = n2298;
      14'b00001000000000: n2819 = n1127;
      14'b00000100000000: n2819 = n2180;
      14'b00000010000000: n2819 = n1127;
      14'b00000001000000: n2819 = n1912;
      14'b00000000100000: n2819 = n1127;
      14'b00000000010000: n2819 = n1127;
      14'b00000000001000: n2819 = n1737;
      14'b00000000000100: n2819 = n1127;
      14'b00000000000010: n2819 = n1642;
      14'b00000000000001: n2819 = n1546;
      default: n2819 = n1127;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2821 = n2784;
      14'b01000000000000: n2821 = n2577;
      14'b00100000000000: n2821 = n2474;
      14'b00010000000000: n2821 = n2305;
      14'b00001000000000: n2821 = 2'b00;
      14'b00000100000000: n2821 = n2181;
      14'b00000010000000: n2821 = n2056;
      14'b00000001000000: n2821 = n1913;
      14'b00000000100000: n2821 = n1798;
      14'b00000000010000: n2821 = 2'b00;
      14'b00000000001000: n2821 = 2'b00;
      14'b00000000000100: n2821 = 2'b00;
      14'b00000000000010: n2821 = n1649;
      14'b00000000000001: n2821 = n1548;
      default: n2821 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2823 = n1097;
      14'b01000000000000: n2823 = n1097;
      14'b00100000000000: n2823 = n1097;
      14'b00010000000000: n2823 = n1097;
      14'b00001000000000: n2823 = n1097;
      14'b00000100000000: n2823 = n1097;
      14'b00000010000000: n2823 = n1097;
      14'b00000001000000: n2823 = n1097;
      14'b00000000100000: n2823 = n1097;
      14'b00000000010000: n2823 = n1097;
      14'b00000000001000: n2823 = n1097;
      14'b00000000000100: n2823 = n1097;
      14'b00000000000010: n2823 = n1097;
      14'b00000000000001: n2823 = n1549;
      default: n2823 = n1097;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2825 = n2785;
      14'b01000000000000: n2825 = n2581;
      14'b00100000000000: n2825 = n2475;
      14'b00010000000000: n2825 = n2308;
      14'b00001000000000: n2825 = n2216;
      14'b00000100000000: n2825 = n2182;
      14'b00000010000000: n2825 = n2057;
      14'b00000001000000: n2825 = n1914;
      14'b00000000100000: n2825 = n1801;
      14'b00000000010000: n2825 = n1770;
      14'b00000000001000: n2825 = n1739;
      14'b00000000000100: n2825 = n1696;
      14'b00000000000010: n2825 = n1652;
      14'b00000000000001: n2825 = n1551;
      default: n2825 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2828 = n2786;
      14'b01000000000000: n2828 = n2585;
      14'b00100000000000: n2828 = 2'b00;
      14'b00010000000000: n2828 = n2313;
      14'b00001000000000: n2828 = 2'b00;
      14'b00000100000000: n2828 = 2'b00;
      14'b00000010000000: n2828 = n2059;
      14'b00000001000000: n2828 = 2'b00;
      14'b00000000100000: n2828 = 2'b00;
      14'b00000000010000: n2828 = 2'b00;
      14'b00000000001000: n2828 = 2'b00;
      14'b00000000000100: n2828 = 2'b00;
      14'b00000000000010: n2828 = n1655;
      14'b00000000000001: n2828 = 2'b00;
      default: n2828 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2831 = n2788;
      14'b01000000000000: n2831 = n2587;
      14'b00100000000000: n2831 = 2'b00;
      14'b00010000000000: n2831 = n2315;
      14'b00001000000000: n2831 = 2'b00;
      14'b00000100000000: n2831 = 2'b00;
      14'b00000010000000: n2831 = 2'b00;
      14'b00000001000000: n2831 = 2'b00;
      14'b00000000100000: n2831 = 2'b00;
      14'b00000000010000: n2831 = 2'b00;
      14'b00000000001000: n2831 = 2'b00;
      14'b00000000000100: n2831 = 2'b00;
      14'b00000000000010: n2831 = 2'b00;
      14'b00000000000001: n2831 = 2'b00;
      default: n2831 = 2'b00;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2834 = n2790;
      14'b01000000000000: n2834 = n2589;
      14'b00100000000000: n2834 = 1'b0;
      14'b00010000000000: n2834 = n2317;
      14'b00001000000000: n2834 = 1'b0;
      14'b00000100000000: n2834 = 1'b0;
      14'b00000010000000: n2834 = 1'b0;
      14'b00000001000000: n2834 = 1'b0;
      14'b00000000100000: n2834 = 1'b0;
      14'b00000000010000: n2834 = 1'b0;
      14'b00000000001000: n2834 = 1'b0;
      14'b00000000000100: n2834 = 1'b0;
      14'b00000000000010: n2834 = 1'b0;
      14'b00000000000001: n2834 = 1'b0;
      default: n2834 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2837 = 1'b0;
      14'b01000000000000: n2837 = 1'b0;
      14'b00100000000000: n2837 = n2476;
      14'b00010000000000: n2837 = 1'b0;
      14'b00001000000000: n2837 = 1'b0;
      14'b00000100000000: n2837 = 1'b0;
      14'b00000010000000: n2837 = 1'b0;
      14'b00000001000000: n2837 = 1'b0;
      14'b00000000100000: n2837 = 1'b0;
      14'b00000000010000: n2837 = 1'b0;
      14'b00000000001000: n2837 = 1'b0;
      14'b00000000000100: n2837 = 1'b0;
      14'b00000000000010: n2837 = n1658;
      14'b00000000000001: n2837 = 1'b0;
      default: n2837 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2840 = 1'b0;
      14'b01000000000000: n2840 = 1'b0;
      14'b00100000000000: n2840 = n2478;
      14'b00010000000000: n2840 = 1'b0;
      14'b00001000000000: n2840 = 1'b0;
      14'b00000100000000: n2840 = 1'b0;
      14'b00000010000000: n2840 = 1'b0;
      14'b00000001000000: n2840 = 1'b0;
      14'b00000000100000: n2840 = 1'b0;
      14'b00000000010000: n2840 = 1'b0;
      14'b00000000001000: n2840 = 1'b0;
      14'b00000000000100: n2840 = 1'b0;
      14'b00000000000010: n2840 = 1'b0;
      14'b00000000000001: n2840 = 1'b0;
      default: n2840 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2843 = 1'b0;
      14'b01000000000000: n2843 = 1'b0;
      14'b00100000000000: n2843 = 1'b0;
      14'b00010000000000: n2843 = 1'b0;
      14'b00001000000000: n2843 = n2219;
      14'b00000100000000: n2843 = 1'b0;
      14'b00000010000000: n2843 = 1'b0;
      14'b00000001000000: n2843 = 1'b0;
      14'b00000000100000: n2843 = 1'b0;
      14'b00000000010000: n2843 = 1'b0;
      14'b00000000001000: n2843 = 1'b0;
      14'b00000000000100: n2843 = 1'b0;
      14'b00000000000010: n2843 = 1'b0;
      14'b00000000000001: n2843 = 1'b0;
      default: n2843 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2846 = 1'b0;
      14'b01000000000000: n2846 = 1'b0;
      14'b00100000000000: n2846 = 1'b0;
      14'b00010000000000: n2846 = 1'b0;
      14'b00001000000000: n2846 = 1'b0;
      14'b00000100000000: n2846 = 1'b0;
      14'b00000010000000: n2846 = 1'b0;
      14'b00000001000000: n2846 = 1'b0;
      14'b00000000100000: n2846 = 1'b0;
      14'b00000000010000: n2846 = 1'b0;
      14'b00000000001000: n2846 = 1'b0;
      14'b00000000000100: n2846 = 1'b0;
      14'b00000000000010: n2846 = 1'b0;
      14'b00000000000001: n2846 = n1553;
      default: n2846 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2849 = 1'b0;
      14'b01000000000000: n2849 = 1'b0;
      14'b00100000000000: n2849 = 1'b0;
      14'b00010000000000: n2849 = 1'b0;
      14'b00001000000000: n2849 = 1'b0;
      14'b00000100000000: n2849 = 1'b0;
      14'b00000010000000: n2849 = 1'b0;
      14'b00000001000000: n2849 = 1'b0;
      14'b00000000100000: n2849 = 1'b0;
      14'b00000000010000: n2849 = 1'b0;
      14'b00000000001000: n2849 = 1'b0;
      14'b00000000000100: n2849 = 1'b0;
      14'b00000000000010: n2849 = 1'b0;
      14'b00000000000001: n2849 = n1555;
      default: n2849 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2851 = n2791;
      14'b01000000000000: n2851 = n2515;
      14'b00100000000000: n2851 = n2479;
      14'b00010000000000: n2851 = n2239;
      14'b00001000000000: n2851 = n1100;
      14'b00000100000000: n2851 = n2183;
      14'b00000010000000: n2851 = n1100;
      14'b00000001000000: n2851 = n1915;
      14'b00000000100000: n2851 = n1100;
      14'b00000000010000: n2851 = n1100;
      14'b00000000001000: n2851 = n1740;
      14'b00000000000100: n2851 = n1691;
      14'b00000000000010: n2851 = n1602;
      14'b00000000000001: n2851 = n1558;
      default: n2851 = n1100;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2853 = 1'b0;
      14'b01000000000000: n2853 = 1'b0;
      14'b00100000000000: n2853 = 1'b0;
      14'b00010000000000: n2853 = 1'b0;
      14'b00001000000000: n2853 = 1'b0;
      14'b00000100000000: n2853 = 1'b0;
      14'b00000010000000: n2853 = 1'b0;
      14'b00000001000000: n2853 = 1'b0;
      14'b00000000100000: n2853 = 1'b0;
      14'b00000000010000: n2853 = 1'b0;
      14'b00000000001000: n2853 = 1'b0;
      14'b00000000000100: n2853 = 1'b0;
      14'b00000000000010: n2853 = 1'b0;
      14'b00000000000001: n2853 = n1560;
      default: n2853 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2855 = n1103;
      14'b01000000000000: n2855 = n1103;
      14'b00100000000000: n2855 = n1103;
      14'b00010000000000: n2855 = n1103;
      14'b00001000000000: n2855 = n1103;
      14'b00000100000000: n2855 = n1103;
      14'b00000010000000: n2855 = n1103;
      14'b00000001000000: n2855 = n1103;
      14'b00000000100000: n2855 = n1103;
      14'b00000000010000: n2855 = n1771;
      14'b00000000001000: n2855 = n1741;
      14'b00000000000100: n2855 = n1103;
      14'b00000000000010: n2855 = n1103;
      14'b00000000000001: n2855 = n1563;
      default: n2855 = n1103;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2856 = n1106;
      14'b01000000000000: n2856 = n1106;
      14'b00100000000000: n2856 = n1106;
      14'b00010000000000: n2856 = n1106;
      14'b00001000000000: n2856 = n1106;
      14'b00000100000000: n2856 = n1106;
      14'b00000010000000: n2856 = n1106;
      14'b00000001000000: n2856 = n1106;
      14'b00000000100000: n2856 = n1106;
      14'b00000000010000: n2856 = n1106;
      14'b00000000001000: n2856 = n1106;
      14'b00000000000100: n2856 = n1106;
      14'b00000000000010: n2856 = n1106;
      14'b00000000000001: n2856 = n1565;
      default: n2856 = n1106;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2857 = n1109;
      14'b01000000000000: n2857 = n1109;
      14'b00100000000000: n2857 = n1109;
      14'b00010000000000: n2857 = n1109;
      14'b00001000000000: n2857 = n1109;
      14'b00000100000000: n2857 = n1109;
      14'b00000010000000: n2857 = n1109;
      14'b00000001000000: n2857 = n1109;
      14'b00000000100000: n2857 = n1109;
      14'b00000000010000: n2857 = n1109;
      14'b00000000001000: n2857 = n1109;
      14'b00000000000100: n2857 = n1109;
      14'b00000000000010: n2857 = n1109;
      14'b00000000000001: n2857 = n1567;
      default: n2857 = n1109;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2859 = n2793;
      14'b01000000000000: n2859 = n2591;
      14'b00100000000000: n2859 = n2481;
      14'b00010000000000: n2859 = n2319;
      14'b00001000000000: n2859 = n2222;
      14'b00000100000000: n2859 = n2185;
      14'b00000010000000: n2859 = n2061;
      14'b00000001000000: n2859 = n1917;
      14'b00000000100000: n2859 = 1'b0;
      14'b00000000010000: n2859 = 1'b0;
      14'b00000000001000: n2859 = 1'b0;
      14'b00000000000100: n2859 = 1'b0;
      14'b00000000000010: n2859 = n1660;
      14'b00000000000001: n2859 = n1569;
      default: n2859 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2862 = n2795;
      14'b01000000000000: n2862 = n2594;
      14'b00100000000000: n2862 = n2483;
      14'b00010000000000: n2862 = n2322;
      14'b00001000000000: n2862 = 1'b0;
      14'b00000100000000: n2862 = n2187;
      14'b00000010000000: n2862 = 1'b0;
      14'b00000001000000: n2862 = n1919;
      14'b00000000100000: n2862 = 1'b0;
      14'b00000000010000: n2862 = 1'b0;
      14'b00000000001000: n2862 = 1'b0;
      14'b00000000000100: n2862 = 1'b0;
      14'b00000000000010: n2862 = n1663;
      14'b00000000000001: n2862 = 1'b0;
      default: n2862 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2865 = 1'b0;
      14'b01000000000000: n2865 = 1'b0;
      14'b00100000000000: n2865 = n2484;
      14'b00010000000000: n2865 = n2325;
      14'b00001000000000: n2865 = 1'b0;
      14'b00000100000000: n2865 = 1'b0;
      14'b00000010000000: n2865 = 1'b0;
      14'b00000001000000: n2865 = n1920;
      14'b00000000100000: n2865 = n1804;
      14'b00000000010000: n2865 = 1'b0;
      14'b00000000001000: n2865 = 1'b0;
      14'b00000000000100: n2865 = 1'b0;
      14'b00000000000010: n2865 = n1666;
      14'b00000000000001: n2865 = 1'b0;
      default: n2865 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2868 = n2796;
      14'b01000000000000: n2868 = n2597;
      14'b00100000000000: n2868 = 1'b0;
      14'b00010000000000: n2868 = n2328;
      14'b00001000000000: n2868 = 1'b0;
      14'b00000100000000: n2868 = n2188;
      14'b00000010000000: n2868 = n2062;
      14'b00000001000000: n2868 = 1'b0;
      14'b00000000100000: n2868 = 1'b0;
      14'b00000000010000: n2868 = 1'b0;
      14'b00000000001000: n2868 = 1'b0;
      14'b00000000000100: n2868 = 1'b0;
      14'b00000000000010: n2868 = n1669;
      14'b00000000000001: n2868 = 1'b0;
      default: n2868 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2871 = n2797;
      14'b01000000000000: n2871 = n2600;
      14'b00100000000000: n2871 = 1'b0;
      14'b00010000000000: n2871 = n2331;
      14'b00001000000000: n2871 = 1'b0;
      14'b00000100000000: n2871 = n2189;
      14'b00000010000000: n2871 = n2063;
      14'b00000001000000: n2871 = 1'b0;
      14'b00000000100000: n2871 = 1'b0;
      14'b00000000010000: n2871 = 1'b0;
      14'b00000000001000: n2871 = 1'b0;
      14'b00000000000100: n2871 = 1'b0;
      14'b00000000000010: n2871 = n1672;
      14'b00000000000001: n2871 = 1'b0;
      default: n2871 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2874 = n2799;
      14'b01000000000000: n2874 = n2603;
      14'b00100000000000: n2874 = n2486;
      14'b00010000000000: n2874 = n2334;
      14'b00001000000000: n2874 = 1'b0;
      14'b00000100000000: n2874 = n2191;
      14'b00000010000000: n2874 = n2065;
      14'b00000001000000: n2874 = n1922;
      14'b00000000100000: n2874 = n1806;
      14'b00000000010000: n2874 = 1'b0;
      14'b00000000001000: n2874 = 1'b0;
      14'b00000000000100: n2874 = 1'b0;
      14'b00000000000010: n2874 = n1675;
      14'b00000000000001: n2874 = n1571;
      default: n2874 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2877 = n2800;
      14'b01000000000000: n2877 = n2606;
      14'b00100000000000: n2877 = n2487;
      14'b00010000000000: n2877 = n2337;
      14'b00001000000000: n2877 = 1'b0;
      14'b00000100000000: n2877 = n2192;
      14'b00000010000000: n2877 = n2067;
      14'b00000001000000: n2877 = n1923;
      14'b00000000100000: n2877 = n1808;
      14'b00000000010000: n2877 = 1'b0;
      14'b00000000001000: n2877 = 1'b0;
      14'b00000000000100: n2877 = 1'b0;
      14'b00000000000010: n2877 = n1678;
      14'b00000000000001: n2877 = n1573;
      default: n2877 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:234:5 */
  always @*
    case (n2814)
      14'b10000000000000: n2880 = n2802;
      14'b01000000000000: n2880 = n2609;
      14'b00100000000000: n2880 = n2489;
      14'b00010000000000: n2880 = n2340;
      14'b00001000000000: n2880 = 1'b0;
      14'b00000100000000: n2880 = n2194;
      14'b00000010000000: n2880 = 1'b0;
      14'b00000001000000: n2880 = n1925;
      14'b00000000100000: n2880 = 1'b0;
      14'b00000000010000: n2880 = 1'b0;
      14'b00000000001000: n2880 = 1'b0;
      14'b00000000000100: n2880 = 1'b0;
      14'b00000000000010: n2880 = n1681;
      14'b00000000000001: n2880 = 1'b0;
      default: n2880 = 1'b0;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1092:12 */
  assign n2885 = ir[1:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1094:16 */
  assign n2886 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1099:18 */
  assign n2887 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1100:13 */
  assign n2889 = n2887 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1100:24 */
  assign n2891 = n2887 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1100:24 */
  assign n2892 = n2889 | n2891;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1102:13 */
  assign n2894 = n2887 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1104:13 */
  assign n2896 = n2887 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1099:11 */
  assign n2897 = {n2896, n2894, n2892};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1099:11 */
  always @*
    case (n2897)
      3'b100: n2902 = 5'b01100;
      3'b010: n2902 = 5'b00101;
      3'b001: n2902 = 5'b00110;
      default: n2902 = 5'b00100;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1098:9 */
  assign n2904 = n2886 == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1098:20 */
  assign n2906 = n2886 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1098:20 */
  assign n2907 = n2904 | n2906;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1098:28 */
  assign n2909 = n2886 == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1098:28 */
  assign n2910 = n2907 | n2909;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1112:18 */
  assign n2911 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1113:13 */
  assign n2913 = n2911 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1113:24 */
  assign n2915 = n2911 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1113:24 */
  assign n2916 = n2913 | n2915;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1115:13 */
  assign n2918 = n2911 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1112:11 */
  assign n2919 = {n2918, n2916};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1112:11 */
  always @*
    case (n2919)
      2'b10: n2923 = 5'b01101;
      2'b01: n2923 = 5'b01110;
      default: n2923 = 5'b00101;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1111:9 */
  assign n2925 = n2886 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1123:18 */
  assign n2926 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1124:13 */
  assign n2928 = n2926 == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1123:11 */
  always @*
    case (n2928)
      1'b1: n2931 = 5'b00101;
      default: n2931 = 5'b00100;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1122:9 */
  assign n2933 = n2886 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1134:18 */
  assign n2934 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1135:13 */
  assign n2936 = n2934 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1134:11 */
  always @*
    case (n2936)
      1'b1: n2939 = 5'b00101;
      default: n2939 = 5'b00100;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1094:9 */
  assign n2940 = {n2933, n2925, n2910};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1094:9 */
  always @*
    case (n2940)
      3'b100: n2941 = n2931;
      3'b010: n2941 = n2923;
      3'b001: n2941 = n2902;
      default: n2941 = n2939;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1093:7 */
  assign n2943 = n2885 == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1143:36 */
  assign n2944 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1143:14 */
  assign n2945 = {28'b0, n2944};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1144:11 */
  assign n2947 = n2945 == 31'b0000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1146:11 */
  assign n2949 = n2945 == 31'b0000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1148:11 */
  assign n2951 = n2945 == 31'b0000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1150:11 */
  assign n2953 = n2945 == 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1152:11 */
  assign n2955 = n2945 == 31'b0000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1154:11 */
  assign n2957 = n2945 == 31'b0000000000000000000000000000101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1156:11 */
  assign n2959 = n2945 == 31'b0000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1143:9 */
  assign n2960 = {n2959, n2957, n2955, n2953, n2951, n2949, n2947};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1143:9 */
  always @*
    case (n2960)
      7'b1000000: n2969 = 5'b00110;
      7'b0100000: n2969 = 5'b00101;
      7'b0010000: n2969 = 5'b00100;
      7'b0001000: n2969 = 5'b00011;
      7'b0000100: n2969 = 5'b00010;
      7'b0000010: n2969 = 5'b00001;
      7'b0000001: n2969 = 5'b00000;
      default: n2969 = 5'b00111;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1142:7 */
  assign n2971 = n2885 == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1163:36 */
  assign n2972 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1163:14 */
  assign n2973 = {28'b0, n2972};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1166:18 */
  assign n2974 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1166:31 */
  assign n2976 = n2974 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1166:47 */
  assign n2978 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1166:39 */
  assign n2979 = n2978 & n2976;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1166:13 */
  assign n2982 = n2979 ? 5'b01110 : 5'b01000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1164:11 */
  assign n2985 = n2973 == 31'b0000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1171:18 */
  assign n2986 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1171:31 */
  assign n2988 = n2986 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1171:47 */
  assign n2990 = mode != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1171:39 */
  assign n2991 = n2990 & n2988;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1171:13 */
  assign n2994 = n2991 ? 5'b01101 : 5'b01001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1169:11 */
  assign n2997 = n2973 == 31'b0000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1174:11 */
  assign n2999 = n2973 == 31'b0000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1176:11 */
  assign n3001 = n2973 == 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1180:18 */
  assign n3002 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1180:31 */
  assign n3004 = n3002 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1180:13 */
  assign n3007 = n3004 ? 5'b00101 : 5'b00100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1178:11 */
  assign n3010 = n2973 == 31'b0000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1185:11 */
  assign n3012 = n2973 == 31'b0000000000000000000000000000101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1187:11 */
  assign n3014 = n2973 == 31'b0000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1163:9 */
  assign n3015 = {n3014, n3012, n3010, n3001, n2999, n2997, n2985};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1163:9 */
  always @*
    case (n3015)
      7'b1000000: n3021 = 5'b01101;
      7'b0100000: n3021 = 5'b00101;
      7'b0010000: n3021 = n3007;
      7'b0001000: n3021 = 5'b01011;
      7'b0000100: n3021 = 5'b01010;
      7'b0000010: n3021 = n2994;
      7'b0000001: n3021 = n2982;
      default: n3021 = 5'b01110;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1162:7 */
  assign n3023 = n2885 == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1194:36 */
  assign n3024 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1194:14 */
  assign n3025 = {28'b0, n3024};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1197:18 */
  assign n3027 = ir == 8'b10111011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1197:13 */
  assign n3030 = n3027 ? 5'b00001 : 5'b00101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1196:11 */
  assign n3032 = n3025 == 31'b0000000000000000000000000000101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1211:18 */
  assign n3034 = ir == 8'b01101011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1213:21 */
  assign n3036 = ir == 8'b10001011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1215:21 */
  assign n3038 = ir == 8'b00001011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1215:33 */
  assign n3040 = ir == 8'b00101011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1215:28 */
  assign n3041 = n3038 | n3040;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1217:21 */
  assign n3043 = ir == 8'b11101011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1220:42 */
  assign n3044 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1220:20 */
  assign n3045 = {28'b0, n3044};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1221:17 */
  assign n3047 = n3045 == 31'b0000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1223:17 */
  assign n3049 = n3045 == 31'b0000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1225:17 */
  assign n3051 = n3045 == 31'b0000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1227:17 */
  assign n3053 = n3045 == 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1229:17 */
  assign n3055 = n3045 == 31'b0000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1231:17 */
  assign n3057 = n3045 == 31'b0000000000000000000000000000101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1233:17 */
  assign n3059 = n3045 == 31'b0000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1220:15 */
  assign n3060 = {n3059, n3057, n3055, n3053, n3051, n3049, n3047};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1220:15 */
  always @*
    case (n3060)
      7'b1000000: n3069 = 5'b00110;
      7'b0100000: n3069 = 5'b00101;
      7'b0010000: n3069 = 5'b00100;
      7'b0001000: n3069 = 5'b00011;
      7'b0000100: n3069 = 5'b00010;
      7'b0000010: n3069 = 5'b00001;
      7'b0000001: n3069 = 5'b00000;
      default: n3069 = 5'b00111;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1239:42 */
  assign n3070 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1239:20 */
  assign n3071 = {28'b0, n3070};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1240:17 */
  assign n3073 = n3071 == 31'b0000000000000000000000000000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1242:17 */
  assign n3075 = n3071 == 31'b0000000000000000000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1244:17 */
  assign n3077 = n3071 == 31'b0000000000000000000000000000010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1246:17 */
  assign n3079 = n3071 == 31'b0000000000000000000000000000011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1248:17 */
  assign n3081 = n3071 == 31'b0000000000000000000000000000100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1250:17 */
  assign n3083 = n3071 == 31'b0000000000000000000000000000101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1254:24 */
  assign n3084 = ir[4:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1254:36 */
  assign n3086 = n3084 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1254:19 */
  assign n3089 = n3086 ? 5'b10001 : 5'b01101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1252:17 */
  assign n3092 = n3071 == 31'b0000000000000000000000000000110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1239:15 */
  assign n3093 = {n3092, n3083, n3081, n3079, n3077, n3075, n3073};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1239:15 */
  always @*
    case (n3093)
      7'b1000000: n3101 = n3089;
      7'b0100000: n3101 = 5'b00101;
      7'b0010000: n3101 = 5'b01100;
      7'b0001000: n3101 = 5'b01011;
      7'b0000100: n3101 = 5'b01010;
      7'b0000010: n3101 = 5'b01001;
      7'b0000001: n3101 = 5'b01000;
      default: n3101 = 5'b01110;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1219:13 */
  assign n3102 = alumore ? n3069 : n3101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1217:13 */
  assign n3104 = n3043 ? 5'b00111 : n3102;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1215:13 */
  assign n3106 = n3041 ? 5'b10000 : n3104;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1213:13 */
  assign n3108 = n3036 ? 5'b10010 : n3106;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1211:13 */
  assign n3110 = n3034 ? 5'b01111 : n3108;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1194:9 */
  always @*
    case (n3032)
      1'b1: n3111 = n3030;
      default: n3111 = n3110;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1092:5 */
  assign n3112 = {n3023, n2971, n2943};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65_MCode.vhd:1092:5 */
  always @*
    case (n3112)
      3'b100: n3113 = n3021;
      3'b010: n3113 = n2969;
      3'b001: n3113 = n2941;
      default: n3113 = n3111;
    endcase
endmodule

module T65
  (input  [1:0] Mode,
   input  BCD_en,
   input  Res_n,
   input  Enable,
   input  Clk,
   input  Rdy,
   input  Abort_n,
   input  IRQ_n,
   input  NMI_n,
   input  SO_n,
   output R_W_n,
   output Sync,
   output EF,
   output MF,
   output XF,
   output ML_n,
   output VP_n,
   output VDA,
   output VPA,
   output [23:0] A,
   input  [7:0] DI,
   output [7:0] DO,
   output [63:0] Regs,
   output [7:0] \DEBUG[I] ,
   output [7:0] \DEBUG[A] ,
   output [7:0] \DEBUG[X] ,
   output [7:0] \DEBUG[Y] ,
   output [7:0] \DEBUG[S] ,
   output [7:0] \DEBUG[P] ,
   output NMI_ack);
  wire [7:0] n13;
  wire [7:0] n14;
  wire [7:0] n15;
  wire [7:0] n16;
  wire [7:0] n17;
  wire [7:0] n18;
  wire [15:0] abc;
  wire [15:0] x;
  wire [15:0] y;
  reg [7:0] p;
  reg [7:0] ad;
  reg [7:0] dl;
  wire [7:0] pwithb;
  wire [7:0] bah;
  wire [8:0] bal;
  wire [7:0] pbr;
  wire [7:0] dbr;
  wire [15:0] pc;
  wire [15:0] s;
  wire ef_i;
  wire mf_i;
  wire xf_i;
  wire [7:0] ir;
  wire [2:0] mcycle;
  wire [7:0] do_r;
  wire [1:0] mode_r;
  wire bcd_en_r;
  wire [4:0] alu_op_r;
  wire [3:0] write_data_r;
  wire [1:0] set_addr_to_r;
  wire [8:0] pcadder;
  wire rstcycle;
  wire irqcycle;
  wire nmicycle;
  wire irqreq;
  wire nmireq;
  wire so_n_o;
  wire irq_n_o;
  wire nmi_n_o;
  wire nmiact;
  wire break;
  wire [7:0] busa;
  wire [7:0] busa_r;
  wire [7:0] busb;
  wire [7:0] busb_r;
  wire [7:0] alu_q;
  wire [7:0] p_out;
  wire [2:0] lcycle;
  wire [4:0] alu_op;
  wire [3:0] set_busa_to;
  wire [1:0] set_addr_to;
  wire [3:0] write_data;
  wire [1:0] jump;
  wire [1:0] baadd;
  wire [1:0] baquirk;
  wire breakatna;
  wire adadd;
  wire addy;
  wire pcadd;
  wire inc_s;
  wire dec_s;
  wire lda;
  wire ldp;
  wire ldx;
  wire ldy;
  wire lds;
  wire lddi;
  wire ldalu;
  wire ldad;
  wire ldbal;
  wire ldbah;
  wire savep;
  wire write;
  wire res_n_i;
  wire res_n_d;
  wire rdy_mod;
  wire really_rdy;
  wire wrn_i;
  wire nmi_entered;
  wire n23;
  wire n24;
  wire n27;
  wire n28;
  wire [1:0] n31;
  wire n33;
  wire [1:0] n34;
  wire n36;
  wire n37;
  wire [1:0] n38;
  wire n40;
  wire n41;
  wire n42;
  wire n46;
  wire n48;
  wire n49;
  wire n50;
  wire n51;
  wire n55;
  wire n56;
  wire n59;
  wire n60;
  wire n61;
  wire [7:0] n63;
  wire [7:0] n64;
  wire [7:0] n65;
  wire [7:0] n66;
  wire [31:0] n67;
  wire [39:0] n68;
  wire [7:0] n69;
  wire [47:0] n70;
  wire [7:0] n71;
  wire [55:0] n72;
  wire [7:0] n73;
  wire [63:0] n74;
  wire n105;
  wire n117;
  wire n120;
  wire n122;
  wire n124;
  wire n125;
  wire n127;
  wire n129;
  wire n130;
  wire n131;
  wire n132;
  wire n133;
  wire n135;
  wire n137;
  wire n138;
  wire n139;
  wire n141;
  wire n142;
  wire n143;
  wire n144;
  wire [15:0] n146;
  wire [15:0] n147;
  wire n148;
  wire [7:0] n150;
  wire n153;
  wire n155;
  wire n159;
  wire [7:0] n161;
  wire [7:0] n162;
  wire n163;
  wire n165;
  wire [1:0] n172;
  wire [15:0] n174;
  wire [7:0] n175;
  wire [15:0] n176;
  wire [15:0] n177;
  wire n178;
  wire n180;
  wire n181;
  wire n182;
  wire [15:0] n184;
  wire [15:0] n185;
  wire n187;
  wire n189;
  wire n190;
  wire n191;
  wire n192;
  wire n193;
  wire n194;
  wire [15:0] n196;
  wire [15:0] n197;
  wire [15:0] n199;
  wire n201;
  wire [15:0] n202;
  wire n204;
  wire n205;
  wire n206;
  wire n207;
  wire [7:0] n208;
  wire [7:0] n210;
  wire [7:0] n211;
  wire [7:0] n213;
  wire [7:0] n214;
  wire [7:0] n215;
  wire [7:0] n216;
  wire [7:0] n217;
  wire n219;
  wire [2:0] n220;
  wire [7:0] n221;
  wire [7:0] n222;
  wire [7:0] n223;
  reg [7:0] n224;
  wire [7:0] n225;
  wire [7:0] n226;
  wire [7:0] n227;
  reg [7:0] n228;
  wire [15:0] n234;
  wire n243;
  wire n244;
  wire n245;
  wire n249;
  wire n250;
  wire n252;
  wire n253;
  wire n254;
  wire n255;
  wire n256;
  wire n257;
  wire n258;
  wire n259;
  wire n260;
  wire n261;
  wire n262;
  wire n263;
  wire n264;
  wire n265;
  wire n266;
  wire n268;
  wire [7:0] n320;
  wire [8:0] n321;
  wire n322;
  wire [8:0] n323;
  wire [8:0] n324;
  wire [8:0] n325;
  wire [7:0] n326;
  wire [8:0] n328;
  wire n332;
  wire n335;
  wire n342;
  wire n343;
  wire [7:0] n344;
  wire n346;
  wire n348;
  wire n350;
  wire n351;
  wire [7:0] n352;
  wire [7:0] n353;
  wire [4:0] n354;
  wire n356;
  wire [2:0] n357;
  wire n360;
  wire n363;
  wire n366;
  wire n369;
  wire n372;
  wire n375;
  wire n378;
  wire [6:0] n379;
  wire n380;
  reg n381;
  wire n382;
  reg n383;
  wire n384;
  reg n385;
  wire n386;
  reg n387;
  wire [1:0] n388;
  wire n389;
  wire n390;
  wire [1:0] n391;
  wire [1:0] n392;
  wire n393;
  wire n394;
  wire n397;
  wire n398;
  wire n403;
  wire n405;
  wire n406;
  wire n407;
  wire n408;
  wire n410;
  wire n411;
  wire n412;
  wire [1:0] n415;
  wire [1:0] n416;
  wire [1:0] n417;
  wire [7:0] n419;
  wire n421;
  wire n423;
  wire n425;
  wire [7:0] n426;
  wire n430;
  wire n432;
  wire n434;
  wire n435;
  wire n437;
  wire n438;
  wire n440;
  wire n441;
  wire n442;
  wire [5:0] n443;
  wire [7:0] n450;
  wire n467;
  wire n470;
  wire n472;
  wire n473;
  wire [7:0] n475;
  wire [7:0] n478;
  wire [8:0] n480;
  wire n482;
  wire [7:0] n483;
  wire [8:0] n484;
  wire [8:0] n485;
  wire [8:0] n486;
  wire n488;
  wire n489;
  wire [7:0] n491;
  wire n493;
  wire [7:0] n495;
  wire [7:0] n496;
  wire n498;
  wire n500;
  wire [2:0] n501;
  reg [7:0] n502;
  wire [7:0] n503;
  wire n505;
  wire [2:0] n506;
  reg [7:0] n507;
  reg [7:0] n508;
  reg [8:0] n509;
  wire [7:0] n510;
  wire [7:0] n511;
  wire [7:0] n512;
  wire [7:0] n513;
  wire [7:0] n514;
  wire [7:0] n515;
  wire n517;
  wire n520;
  wire n521;
  wire n522;
  wire n523;
  wire n526;
  wire n529;
  wire [2:0] n531;
  wire n533;
  wire [2:0] n534;
  localparam [8:0] n535 = 9'b111111111;
  wire [5:0] n536;
  wire n538;
  wire n540;
  wire n542;
  wire n543;
  wire [1:0] n544;
  wire [7:0] n546;
  wire [8:0] n547;
  wire [8:0] n548;
  wire n550;
  wire [7:0] n552;
  wire [7:0] n553;
  wire [7:0] n554;
  wire [7:0] n555;
  wire [7:0] n556;
  wire n557;
  wire [7:0] n558;
  wire [8:0] n562;
  wire n566;
  wire n568;
  wire n569;
  wire n570;
  wire n571;
  wire n572;
  wire n573;
  wire n574;
  wire n575;
  wire n600;
  wire n601;
  wire n602;
  wire n603;
  wire n604;
  wire n605;
  wire n606;
  wire n608;
  wire [7:0] n609;
  wire n611;
  wire [7:0] n612;
  wire n614;
  wire [7:0] n615;
  wire n617;
  wire [7:0] n618;
  wire n620;
  wire n622;
  wire [7:0] n623;
  wire [7:0] n624;
  wire n626;
  wire [7:0] n627;
  wire [7:0] n629;
  wire [7:0] n630;
  wire n632;
  wire [7:0] n633;
  wire [7:0] n635;
  wire [7:0] n636;
  wire [7:0] n637;
  wire [7:0] n638;
  wire n640;
  wire [7:0] n641;
  wire [7:0] n642;
  wire [7:0] n643;
  wire n645;
  wire n648;
  wire [10:0] n649;
  reg [7:0] n651;
  wire [7:0] n652;
  wire [23:0] n654;
  wire n656;
  wire [15:0] n658;
  wire [23:0] n659;
  wire n661;
  wire [15:0] n663;
  wire [7:0] n664;
  wire [23:0] n665;
  wire n667;
  wire [7:0] n668;
  wire [15:0] n669;
  wire [7:0] n670;
  wire [23:0] n671;
  wire n673;
  wire [3:0] n674;
  reg [23:0] n676;
  wire [7:0] n678;
  wire n679;
  wire [7:0] n680;
  wire n682;
  wire [7:0] n683;
  wire n685;
  wire [7:0] n686;
  wire n688;
  wire [7:0] n689;
  wire n691;
  wire [7:0] n692;
  wire n694;
  wire n696;
  wire [7:0] n697;
  wire n699;
  wire [7:0] n700;
  wire n702;
  wire [7:0] n703;
  wire [7:0] n704;
  wire [7:0] n705;
  wire n707;
  wire [7:0] n708;
  wire [7:0] n709;
  wire [7:0] n710;
  wire [7:0] n711;
  wire n713;
  wire [7:0] n714;
  wire [7:0] n715;
  wire n717;
  wire [7:0] n718;
  wire [7:0] n719;
  wire n721;
  wire n724;
  wire [12:0] n725;
  reg [7:0] n727;
  wire n730;
  wire n732;
  wire n733;
  wire [2:0] n735;
  wire [2:0] n737;
  wire [4:0] n740;
  wire n742;
  wire n744;
  wire n745;
  wire n747;
  wire n748;
  wire n751;
  wire n752;
  wire n753;
  wire n754;
  wire n755;
  wire n758;
  wire n762;
  wire n763;
  wire n764;
  wire n765;
  wire n766;
  wire n768;
  wire n770;
  wire n771;
  wire n772;
  wire n773;
  wire n774;
  wire [15:0] n799;
  wire [15:0] n801;
  wire [15:0] n803;
  wire [47:0] n804;
  wire n805;
  wire n806;
  wire [7:0] n807;
  wire [7:0] n808;
  reg [7:0] n809;
  wire n810;
  wire n811;
  wire [7:0] n812;
  wire [7:0] n813;
  reg [7:0] n814;
  wire n815;
  wire n816;
  wire [7:0] n817;
  wire [7:0] n818;
  reg [7:0] n819;
  reg [7:0] n820;
  wire [7:0] n821;
  reg [7:0] n822;
  wire [7:0] n823;
  reg [7:0] n824;
  wire [7:0] n825;
  reg [7:0] n826;
  wire [8:0] n827;
  reg [8:0] n828;
  wire [7:0] n829;
  reg [7:0] n830;
  wire [7:0] n831;
  reg [7:0] n832;
  wire [15:0] n833;
  reg [15:0] n834;
  wire [15:0] n835;
  reg [15:0] n836;
  wire n837;
  reg n838;
  wire n839;
  reg n840;
  wire n841;
  reg n842;
  wire [7:0] n843;
  reg [7:0] n844;
  wire [2:0] n845;
  reg [2:0] n846;
  wire [1:0] n847;
  reg [1:0] n848;
  wire n849;
  reg n850;
  wire [4:0] n851;
  reg [4:0] n852;
  wire [3:0] n853;
  reg [3:0] n854;
  wire [1:0] n855;
  reg [1:0] n856;
  wire n857;
  reg n858;
  wire n859;
  reg n860;
  wire n861;
  reg n862;
  wire n863;
  reg n864;
  wire n865;
  reg n866;
  wire n867;
  wire n868;
  reg n869;
  wire n870;
  wire n871;
  wire n872;
  reg n873;
  wire n874;
  wire n875;
  wire n876;
  reg n877;
  wire n878;
  reg n879;
  wire [7:0] n880;
  reg [7:0] n881;
  wire [7:0] n882;
  reg [7:0] n883;
  wire [7:0] n884;
  reg [7:0] n885;
  reg n886;
  reg n887;
  wire n888;
  wire n889;
  wire n890;
  reg n891;
  wire n892;
  reg n893;
  wire n894;
  wire n895;
  wire n896;
  reg n897;
  assign R_W_n = wrn_i; //(module output)
  assign Sync = n28; //(module output)
  assign EF = ef_i; //(module output)
  assign MF = mf_i; //(module output)
  assign XF = xf_i; //(module output)
  assign ML_n = n42; //(module output)
  assign VP_n = n51; //(module output)
  assign VDA = n56; //(module output)
  assign VPA = n61; //(module output)
  assign A = n676; //(module output)
  assign DO = do_r; //(module output)
  assign Regs = n74; //(module output)
  assign \DEBUG[I]  = n13; //(module output)
  assign \DEBUG[A]  = n14; //(module output)
  assign \DEBUG[X]  = n15; //(module output)
  assign \DEBUG[Y]  = n16; //(module output)
  assign \DEBUG[S]  = n17; //(module output)
  assign \DEBUG[P]  = n18; //(module output)
  assign NMI_ack = nmiact; //(module output)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:134:8 */
  assign n13 = n804[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:134:8 */
  assign n14 = n804[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:134:8 */
  assign n15 = n804[23:16]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:134:8 */
  assign n16 = n804[31:24]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:134:8 */
  assign n17 = n804[39:32]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:134:8 */
  assign n18 = n804[47:40]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:10 */
  assign abc = n799; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:15 */
  assign x = n801; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:18 */
  assign y = n803; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:170:10 */
  always @*
    p = n820; // (isignal)
  initial
    p = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:170:13 */
  always @*
    ad = n822; // (isignal)
  initial
    ad = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:170:17 */
  always @*
    dl = n824; // (isignal)
  initial
    dl = 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:171:10 */
  assign pwithb = n680; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:172:10 */
  assign bah = n826; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:173:10 */
  assign bal = n828; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:174:10 */
  assign pbr = n830; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:175:10 */
  assign dbr = n832; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:176:10 */
  assign pc = n834; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:177:10 */
  assign s = n836; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:178:10 */
  assign ef_i = n838; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:179:10 */
  assign mf_i = n840; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:180:10 */
  assign xf_i = n842; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:182:10 */
  assign ir = n844; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:183:10 */
  assign mcycle = n846; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:185:10 */
  assign do_r = n727; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:187:10 */
  assign mode_r = n848; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:188:10 */
  assign bcd_en_r = n850; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:189:10 */
  assign alu_op_r = n852; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:190:10 */
  assign write_data_r = n854; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:191:10 */
  assign set_addr_to_r = n856; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:192:10 */
  assign pcadder = n325; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:194:10 */
  assign rstcycle = n858; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:195:10 */
  assign irqcycle = n860; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:196:10 */
  assign nmicycle = n862; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:197:10 */
  assign irqreq = n864; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:198:10 */
  assign nmireq = n866; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:200:10 */
  assign so_n_o = n869; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:201:10 */
  assign irq_n_o = n873; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:202:10 */
  assign nmi_n_o = n877; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:203:10 */
  assign nmiact = n879; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:205:10 */
  assign break = n606; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:208:10 */
  assign busa = n651; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:209:10 */
  assign busa_r = n881; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:210:10 */
  assign busb = n883; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:211:10 */
  assign busb_r = n885; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:243:10 */
  assign res_n_i = n886; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:244:10 */
  assign res_n_d = n887; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:246:10 */
  assign rdy_mod = n891; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:247:10 */
  assign really_rdy = n24; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:248:10 */
  assign wrn_i = n893; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:250:10 */
  assign nmi_entered = n897; // (signal)
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:256:24 */
  assign n23 = ~wrn_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:256:21 */
  assign n24 = Rdy | n23;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:257:27 */
  assign n27 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:257:15 */
  assign n28 = n27 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:22 */
  assign n31 = ir[7:6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:35 */
  assign n33 = n31 != 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:49 */
  assign n34 = ir[2:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:62 */
  assign n36 = n34 == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:43 */
  assign n37 = n36 & n33;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:79 */
  assign n38 = mcycle[2:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:92 */
  assign n40 = n38 != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:69 */
  assign n41 = n40 & n37;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:262:15 */
  assign n42 = n41 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:263:47 */
  assign n46 = mcycle == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:263:65 */
  assign n48 = mcycle == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:263:55 */
  assign n49 = n46 | n48;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:263:35 */
  assign n50 = n49 & irqcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:263:15 */
  assign n51 = n50 ? 1'b0 : 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:264:33 */
  assign n55 = set_addr_to_r != 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:264:14 */
  assign n56 = n55 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:265:23 */
  assign n59 = jump[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:265:27 */
  assign n60 = ~n59;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:265:14 */
  assign n61 = n60 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:269:17 */
  assign n63 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:270:15 */
  assign n64 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:271:15 */
  assign n65 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:272:32 */
  assign n66 = s[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:32 */
  assign n67 = {pc, s};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:53 */
  assign n68 = {n67, p};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:60 */
  assign n69 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:57 */
  assign n70 = {n68, n69};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:76 */
  assign n71 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:73 */
  assign n72 = {n70, n71};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:94 */
  assign n73 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:275:89 */
  assign n74 = {n72, n73};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:277:3 */
  t65_mcode_Brtl mcode (
    .mode(mode_r),
    .ir(ir),
    .mcycle(mcycle),
    .p(p),
    .rdy_mod(rdy_mod),
    .lcycle(lcycle),
    .alu_op(alu_op),
    .set_busa_to(set_busa_to),
    .set_addr_to(set_addr_to),
    .write_data(write_data),
    .jump(jump),
    .baadd(baadd),
    .baquirk(baquirk),
    .breakatna(breakatna),
    .adadd(adadd),
    .addy(addy),
    .pcadd(pcadd),
    .inc_s(inc_s),
    .dec_s(dec_s),
    .lda(lda),
    .ldp(ldp),
    .ldx(ldx),
    .ldy(ldy),
    .lds(lds),
    .lddi(lddi),
    .ldalu(ldalu),
    .ldad(ldad),
    .ldbal(ldbal),
    .ldbah(ldbah),
    .savep(savep),
    .write(write));
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:314:3 */
  t65_alu_Brtl alu (
    .mode(mode_r),
    .bcd_en(bcd_en_r),
    .op(alu_op_r),
    .busa(busa_r),
    .busb(busb),
    .p_in(p),
    .p_out(p_out),
    .q(alu_q));
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:330:14 */
  assign n105 = ~Res_n;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:341:16 */
  assign n117 = ~res_n_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:365:20 */
  assign n120 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:24 */
  assign n122 = mcycle == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:39 */
  assign n124 = ir != 8'b10010011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:32 */
  assign n125 = n124 & n122;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:60 */
  assign n127 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:75 */
  assign n129 = ir == 8'b10010011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:68 */
  assign n130 = n129 & n127;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:49 */
  assign n131 = n125 | n130;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:93 */
  assign n132 = ~Rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:85 */
  assign n133 = n132 & n131;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:367:9 */
  assign n135 = n133 ? 1'b1 : rdy_mod;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:365:9 */
  assign n137 = n120 ? 1'b0 : n135;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:372:20 */
  assign n138 = ~write;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:372:30 */
  assign n139 = n138 | rstcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:380:22 */
  assign n141 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:384:23 */
  assign n142 = ~irqreq;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:384:40 */
  assign n143 = ~nmireq;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:384:29 */
  assign n144 = n143 & n142;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:385:24 */
  assign n146 = pc + 16'b0000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:380:11 */
  assign n147 = n163 ? n146 : pc;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:388:29 */
  assign n148 = irqreq | nmireq;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:388:13 */
  assign n150 = n148 ? 8'b00000000 : DI;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:398:13 */
  assign n153 = irqreq ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:396:13 */
  assign n155 = nmireq ? 1'b0 : n153;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:396:13 */
  assign n159 = nmireq ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:177:10 */
  assign n161 = s[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:380:11 */
  assign n162 = n165 ? alu_q : n161;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:380:11 */
  assign n163 = n144 & n141;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:380:11 */
  assign n165 = lds & n141;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:409:11 */
  assign n172 = break ? 2'b00 : set_addr_to;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:416:20 */
  assign n174 = s + 16'b0000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:177:10 */
  assign n175 = s[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:177:10 */
  assign n176 = {n175, n162};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:415:11 */
  assign n177 = inc_s ? n174 : n176;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:418:40 */
  assign n178 = ~rstcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:418:54 */
  assign n180 = Mode == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:418:46 */
  assign n181 = n178 | n180;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:418:26 */
  assign n182 = n181 & dec_s;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:419:20 */
  assign n184 = s - 16'b0000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:418:11 */
  assign n185 = n182 ? n184 : n177;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:17 */
  assign n187 = ir == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:41 */
  assign n189 = mcycle == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:30 */
  assign n190 = n189 & n187;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:62 */
  assign n191 = ~irqcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:49 */
  assign n192 = n191 & n190;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:81 */
  assign n193 = ~nmicycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:68 */
  assign n194 = n193 & n192;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:423:22 */
  assign n196 = pc + 16'b0000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:422:11 */
  assign n197 = n194 ? n196 : n147;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:430:24 */
  assign n199 = pc + 16'b0000000000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:429:13 */
  assign n201 = jump == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:432:33 */
  assign n202 = {DI, dl};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:431:13 */
  assign n204 = jump == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:434:25 */
  assign n205 = pcadder[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:435:22 */
  assign n206 = dl[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:435:26 */
  assign n207 = ~n206;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:436:40 */
  assign n208 = pc[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:436:54 */
  assign n210 = n208 + 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:438:40 */
  assign n211 = pc[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:438:54 */
  assign n213 = n211 - 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:435:17 */
  assign n214 = n207 ? n210 : n213;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:176:10 */
  assign n215 = n197[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:434:15 */
  assign n216 = n205 ? n214 : n215;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:441:40 */
  assign n217 = pcadder[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:433:13 */
  assign n219 = jump == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:428:11 */
  assign n220 = {n219, n204, n201};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:430:24 */
  assign n221 = n199[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:432:33 */
  assign n222 = n202[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:176:10 */
  assign n223 = n197[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:428:11 */
  always @*
    case (n220)
      3'b100: n224 = n217;
      3'b010: n224 = n222;
      3'b001: n224 = n221;
      default: n224 = n223;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:430:24 */
  assign n225 = n199[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:432:33 */
  assign n226 = n202[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:176:10 */
  assign n227 = n197[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:428:11 */
  always @*
    case (n220)
      3'b100: n228 = n216;
      3'b010: n228 = n226;
      3'b001: n228 = n225;
      default: n228 = n227;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:371:9 */
  assign n234 = {n228, n224};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:371:9 */
  assign n243 = n141 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:371:9 */
  assign n244 = n141 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:371:9 */
  assign n245 = n141 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:371:9 */
  assign n249 = n141 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:371:9 */
  assign n250 = n141 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n252 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n253 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n254 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n255 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n256 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n257 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n258 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n259 = n243 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n260 = n244 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n261 = n245 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n262 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n263 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n264 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n265 = n249 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n266 = n250 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:363:7 */
  assign n268 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:449:23 */
  assign n320 = pc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:449:14 */
  assign n321 = {1'b0, n320};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:449:59 */
  assign n322 = dl[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:449:63 */
  assign n323 = {n322, dl};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:449:39 */
  assign n324 = n321 + n323;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:449:72 */
  assign n325 = pcadd ? n324 : n328;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:450:23 */
  assign n326 = pc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:450:19 */
  assign n328 = {1'b0, n326};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:455:16 */
  assign n332 = ~res_n_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:461:21 */
  assign n335 = mcycle == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:471:21 */
  assign n342 = lda | ldx;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:471:28 */
  assign n343 = n342 | ldy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:461:11 */
  assign n344 = n351 ? p_out : p;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:461:11 */
  assign n346 = lda & n335;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:461:11 */
  assign n348 = ldx & n335;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:461:11 */
  assign n350 = ldy & n335;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:461:11 */
  assign n351 = n343 & n335;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:475:11 */
  assign n352 = savep ? p_out : n344;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:478:11 */
  assign n353 = ldp ? alu_q : n352;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:481:16 */
  assign n354 = ir[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:481:29 */
  assign n356 = n354 == 5'b11000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:482:20 */
  assign n357 = ir[7:5]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:483:13 */
  assign n360 = n357 == 3'b000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:485:13 */
  assign n363 = n357 == 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:487:13 */
  assign n366 = n357 == 3'b010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:489:13 */
  assign n369 = n357 == 3'b011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:491:13 */
  assign n372 = n357 == 3'b101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:493:13 */
  assign n375 = n357 == 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:495:13 */
  assign n378 = n357 == 3'b111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:482:13 */
  assign n379 = {n378, n375, n372, n369, n366, n363, n360};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n380 = n353[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:482:13 */
  always @*
    case (n379)
      7'b1000000: n381 = n380;
      7'b0100000: n381 = n380;
      7'b0010000: n381 = n380;
      7'b0001000: n381 = n380;
      7'b0000100: n381 = n380;
      7'b0000010: n381 = 1'b1;
      7'b0000001: n381 = 1'b0;
      default: n381 = n380;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n382 = n353[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:482:13 */
  always @*
    case (n379)
      7'b1000000: n383 = n382;
      7'b0100000: n383 = n382;
      7'b0010000: n383 = n382;
      7'b0001000: n383 = 1'b1;
      7'b0000100: n383 = 1'b0;
      7'b0000010: n383 = n382;
      7'b0000001: n383 = n382;
      default: n383 = n382;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n384 = n353[3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:482:13 */
  always @*
    case (n379)
      7'b1000000: n385 = 1'b1;
      7'b0100000: n385 = 1'b0;
      7'b0010000: n385 = n384;
      7'b0001000: n385 = n384;
      7'b0000100: n385 = n384;
      7'b0000010: n385 = n384;
      7'b0000001: n385 = n384;
      default: n385 = n384;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n386 = n353[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:482:13 */
  always @*
    case (n379)
      7'b1000000: n387 = n386;
      7'b0100000: n387 = n386;
      7'b0010000: n387 = 1'b0;
      7'b0001000: n387 = n386;
      7'b0000100: n387 = n386;
      7'b0000010: n387 = n386;
      7'b0000001: n387 = n386;
      default: n387 = n386;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:481:11 */
  assign n388 = {n385, n383};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n389 = n353[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:481:11 */
  assign n390 = n356 ? n381 : n389;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n391 = n353[3:2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:481:11 */
  assign n392 = n356 ? n388 : n391;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n393 = n353[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:481:11 */
  assign n394 = n356 ? n387 : n393;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n397 = n353[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n398 = n353[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:501:17 */
  assign n403 = ir == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:501:41 */
  assign n405 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:501:30 */
  assign n406 = n405 & n403;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:501:62 */
  assign n407 = ~rstcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:501:49 */
  assign n408 = n407 & n406;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n410 = n392[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:501:11 */
  assign n411 = n408 ? 1'b1 : n410;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n412 = n392[1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:505:11 */
  assign n415 = {1'b0, 1'b1};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n416 = {n412, n411};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:505:11 */
  assign n417 = rstcycle ? n415 : n416;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:453:14 */
  assign n419 = {n398, n394, 1'b1, 1'b1, n417, n397, n390};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:460:9 */
  assign n421 = n346 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:460:9 */
  assign n423 = n348 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:460:9 */
  assign n425 = n350 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:459:7 */
  assign n426 = n435 ? n419 : p;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:459:7 */
  assign n430 = n421 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:459:7 */
  assign n432 = n423 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:459:7 */
  assign n434 = n425 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:459:7 */
  assign n435 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:519:32 */
  assign n437 = ~SO_n;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:519:23 */
  assign n438 = n437 & so_n_o;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:170:10 */
  assign n440 = n426[6]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:519:7 */
  assign n441 = n438 ? 1'b1 : n440;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:170:10 */
  assign n442 = n426[7]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:170:10 */
  assign n443 = n426[5:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n450 = {n442, n441, n443};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:534:16 */
  assign n467 = ~res_n_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:550:28 */
  assign n470 = set_addr_to_r == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:550:63 */
  assign n472 = set_addr_to_r == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:550:46 */
  assign n473 = n470 | n472;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:551:65 */
  assign n475 = DI + 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:557:49 */
  assign n478 = ad + 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:558:51 */
  assign n480 = bal + 9'b000000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:555:11 */
  assign n482 = baadd == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:561:56 */
  assign n483 = bal[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:561:37 */
  assign n484 = {1'b0, n483};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:561:75 */
  assign n485 = {1'b0, busa};  // uext
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:561:73 */
  assign n486 = n484 + n485;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:559:11 */
  assign n488 = baadd == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:564:19 */
  assign n489 = bal[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:567:66 */
  assign n491 = bah + 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:567:15 */
  assign n493 = baquirk == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:568:66 */
  assign n495 = bah + 8'b00000001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:568:71 */
  assign n496 = n495 & do_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:568:15 */
  assign n498 = baquirk == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:569:15 */
  assign n500 = baquirk == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:566:15 */
  assign n501 = {n500, n498, n493};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:566:15 */
  always @*
    case (n501)
      3'b100: n502 = do_r;
      3'b010: n502 = n496;
      3'b001: n502 = n491;
      default: n502 = bah;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:564:13 */
  assign n503 = n489 ? n502 : bah;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:562:11 */
  assign n505 = baadd == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:554:11 */
  assign n506 = {n505, n488, n482};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:554:11 */
  always @*
    case (n506)
      3'b100: n507 = ad;
      3'b010: n507 = ad;
      3'b001: n507 = n478;
      default: n507 = ad;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:554:11 */
  always @*
    case (n506)
      3'b100: n508 = n503;
      3'b010: n508 = bah;
      3'b001: n508 = bah;
      default: n508 = bah;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:554:11 */
  always @*
    case (n506)
      3'b100: n509 = bal;
      3'b010: n509 = n486;
      3'b001: n509 = n480;
      default: n509 = bal;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:579:63 */
  assign n510 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:579:51 */
  assign n511 = ad + n510;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:581:63 */
  assign n512 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:581:51 */
  assign n513 = ad + n512;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:578:13 */
  assign n514 = addy ? n511 : n513;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:577:11 */
  assign n515 = adadd ? n514 : n507;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:585:17 */
  assign n517 = ir == 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:590:61 */
  assign n520 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:590:51 */
  assign n521 = n520 & nmiact;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:590:34 */
  assign n522 = nmicycle | n521;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:590:69 */
  assign n523 = n522 | nmi_entered;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:592:24 */
  assign n526 = mcycle == 3'b100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:592:15 */
  assign n529 = n526 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:590:13 */
  assign n531 = n523 ? 3'b010 : 3'b110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:590:13 */
  assign n533 = n523 ? n529 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:588:13 */
  assign n534 = rstcycle ? 3'b100 : n531;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:173:10 */
  assign n536 = n535[8:3]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:588:13 */
  assign n538 = rstcycle ? 1'b0 : n533;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:598:30 */
  assign n540 = set_addr_to_r == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:173:10 */
  assign n542 = n534[0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:598:13 */
  assign n543 = n540 ? 1'b1 : n542;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:173:10 */
  assign n544 = n534[2:1]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:585:11 */
  assign n546 = n517 ? 8'b11111111 : n508;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:585:11 */
  assign n547 = {n536, n544, n543};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:585:11 */
  assign n548 = n517 ? n547 : n509;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:585:11 */
  assign n550 = n517 ? n538 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:603:11 */
  assign n552 = lddi ? DI : dl;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:606:11 */
  assign n553 = ldalu ? alu_q : n552;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:609:11 */
  assign n554 = ldad ? DI : n515;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:173:10 */
  assign n555 = n548[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:612:11 */
  assign n556 = ldbal ? DI : n555;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:173:10 */
  assign n557 = n548[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:615:11 */
  assign n558 = ldbah ? DI : n546;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:544:9 */
  assign n562 = {n557, n556};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:544:9 */
  assign n566 = n473 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n568 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n569 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n570 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n571 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n572 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n573 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n574 = n566 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:543:7 */
  assign n575 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:34 */
  assign n600 = bal[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:27 */
  assign n601 = ~n600;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:23 */
  assign n602 = breakatna & n601;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:64 */
  assign n603 = pcadder[8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:53 */
  assign n604 = ~n603;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:49 */
  assign n605 = pcadd & n604;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:623:39 */
  assign n606 = n602 | n605;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:627:45 */
  assign n608 = set_busa_to == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:628:10 */
  assign n609 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:628:45 */
  assign n611 = set_busa_to == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:629:8 */
  assign n612 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:629:45 */
  assign n614 = set_busa_to == 4'b0010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:630:8 */
  assign n615 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:630:45 */
  assign n617 = set_busa_to == 4'b0011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:631:25 */
  assign n618 = s[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:631:45 */
  assign n620 = set_busa_to == 4'b0100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:632:45 */
  assign n622 = set_busa_to == 4'b0101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:633:10 */
  assign n623 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:633:23 */
  assign n624 = n623 & DI;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:633:45 */
  assign n626 = set_busa_to == 4'b0110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:634:11 */
  assign n627 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:634:24 */
  assign n629 = n627 | 8'b11101110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:634:34 */
  assign n630 = n629 & DI;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:634:45 */
  assign n632 = set_busa_to == 4'b0111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:635:11 */
  assign n633 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:635:24 */
  assign n635 = n633 | 8'b11101110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:635:34 */
  assign n636 = n635 & DI;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:635:46 */
  assign n637 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:635:41 */
  assign n638 = n636 & n637;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:635:62 */
  assign n640 = set_busa_to == 4'b1000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:636:10 */
  assign n641 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:636:28 */
  assign n642 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:636:23 */
  assign n643 = n641 & n642;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:636:45 */
  assign n645 = set_busa_to == 4'b1001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:637:45 */
  assign n648 = set_busa_to == 4'b1010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:625:3 */
  assign n649 = {n648, n645, n640, n632, n626, n622, n620, n617, n614, n611, n608};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:625:3 */
  always @*
    case (n649)
      11'b10000000000: n651 = 8'bX;
      11'b01000000000: n651 = n643;
      11'b00100000000: n651 = n638;
      11'b00010000000: n651 = n630;
      11'b00001000000: n651 = n624;
      11'b00000100000: n651 = p;
      11'b00000010000: n651 = n618;
      11'b00000001000: n651 = n615;
      11'b00000000100: n651 = n612;
      11'b00000000010: n651 = n609;
      11'b00000000001: n651 = DI;
      default: n651 = 8'bX;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:641:46 */
  assign n652 = s[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:641:26 */
  assign n654 = {16'b0000000000000001, n652};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:641:87 */
  assign n656 = set_addr_to_r == 2'b01;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:642:11 */
  assign n658 = {dbr, 8'b00000000};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:642:24 */
  assign n659 = {n658, ad};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:642:87 */
  assign n661 = set_addr_to_r == 2'b10;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:643:18 */
  assign n663 = {8'b00000000, bah};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:643:29 */
  assign n664 = bal[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:643:24 */
  assign n665 = {n663, n664};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:643:87 */
  assign n667 = set_addr_to_r == 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:644:32 */
  assign n668 = pc[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:644:11 */
  assign n669 = {pbr, n668};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:644:73 */
  assign n670 = pcadder[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:644:47 */
  assign n671 = {n669, n670};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:644:87 */
  assign n673 = set_addr_to_r == 2'b00;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:639:3 */
  assign n674 = {n673, n667, n661, n656};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:639:3 */
  always @*
    case (n674)
      4'b1000: n676 = n671;
      4'b0100: n676 = n665;
      4'b0010: n676 = n659;
      4'b0001: n676 = n654;
      default: n676 = 24'bX;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:647:14 */
  assign n678 = p & 8'b11101111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:647:44 */
  assign n679 = irqcycle | nmicycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:647:25 */
  assign n680 = n679 ? n678 : p;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:653:43 */
  assign n682 = write_data_r == 4'b0000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:654:10 */
  assign n683 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:654:43 */
  assign n685 = write_data_r == 4'b0001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:655:8 */
  assign n686 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:655:43 */
  assign n688 = write_data_r == 4'b0010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:656:8 */
  assign n689 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:656:43 */
  assign n691 = write_data_r == 4'b0011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:657:25 */
  assign n692 = s[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:657:43 */
  assign n694 = write_data_r == 4'b0100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:658:43 */
  assign n696 = write_data_r == 4'b0101;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:659:26 */
  assign n697 = pc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:659:43 */
  assign n699 = write_data_r == 4'b0110;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:660:26 */
  assign n700 = pc[15:8]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:660:43 */
  assign n702 = write_data_r == 4'b0111;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:661:10 */
  assign n703 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:661:28 */
  assign n704 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:661:23 */
  assign n705 = n703 & n704;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:661:43 */
  assign n707 = write_data_r == 4'b1000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:662:10 */
  assign n708 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:662:28 */
  assign n709 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:662:23 */
  assign n710 = n708 & n709;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:662:41 */
  assign n711 = n710 & busb_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:662:64 */
  assign n713 = write_data_r == 4'b1001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:663:8 */
  assign n714 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:663:21 */
  assign n715 = n714 & busb_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:663:44 */
  assign n717 = write_data_r == 4'b1010;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:664:8 */
  assign n718 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:664:21 */
  assign n719 = n718 & busb_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:664:44 */
  assign n721 = write_data_r == 4'b1011;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:665:43 */
  assign n724 = write_data_r == 4'b1100;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:651:3 */
  assign n725 = {n724, n721, n717, n713, n707, n702, n699, n696, n694, n691, n688, n685, n682};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:651:3 */
  always @*
    case (n725)
      13'b1000000000000: n727 = 8'bX;
      13'b0100000000000: n727 = n719;
      13'b0010000000000: n727 = n715;
      13'b0001000000000: n727 = n711;
      13'b0000100000000: n727 = n705;
      13'b0000010000000: n727 = n700;
      13'b0000001000000: n727 = n697;
      13'b0000000100000: n727 = pwithb;
      13'b0000000010000: n727 = n692;
      13'b0000000001000: n727 = n689;
      13'b0000000000100: n727 = n686;
      13'b0000000000010: n727 = n683;
      13'b0000000000001: n727 = dl;
      default: n727 = 8'bX;
    endcase
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:676:16 */
  assign n730 = ~res_n_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:685:21 */
  assign n732 = mcycle == lcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:685:30 */
  assign n733 = n732 | break;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:689:57 */
  assign n735 = mcycle + 3'b001;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:685:11 */
  assign n737 = n733 ? 3'b000 : n735;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:692:17 */
  assign n740 = ir[4:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:692:29 */
  assign n742 = n740 != 5'b10000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:692:46 */
  assign n744 = jump != 2'b11;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:692:39 */
  assign n745 = n742 | n744;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:693:35 */
  assign n747 = ir != 8'b00000000;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:693:29 */
  assign n748 = n747 & nmiact;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:693:13 */
  assign n751 = n748 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:698:24 */
  assign n752 = ~irq_n_o;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:698:35 */
  assign n753 = p[2]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:698:44 */
  assign n754 = ~n753;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:698:30 */
  assign n755 = n754 & n752;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:698:13 */
  assign n758 = n755 ? 1'b1 : 1'b0;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:684:9 */
  assign n762 = n733 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:684:9 */
  assign n763 = n745 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:684:9 */
  assign n764 = n745 & really_rdy;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:710:36 */
  assign n765 = ~NMI_n;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:710:26 */
  assign n766 = n765 & nmi_n_o;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:710:9 */
  assign n768 = n766 ? 1'b1 : nmiact;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:714:9 */
  assign n770 = nmi_entered ? 1'b0 : n768;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:683:7 */
  assign n771 = really_rdy & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:683:7 */
  assign n772 = n762 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:683:7 */
  assign n773 = n763 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:683:7 */
  assign n774 = n764 & Enable;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:10 */
  assign n799 = {8'bZ, n809};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:15 */
  assign n801 = {8'bZ, n814};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:18 */
  assign n803 = {8'bZ, n819};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:161:5 */
  assign n804 = {p, n66, n65, n64, n63, ir};
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:10 */
  assign n805 = ~n332;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:10 */
  assign n806 = n430 & n805;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n807 = abc[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n808 = n806 ? alu_q : n807;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  always @(posedge Clk)
    n809 <= n808;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:15 */
  assign n810 = ~n332;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:15 */
  assign n811 = n432 & n810;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n812 = x[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n813 = n811 ? alu_q : n812;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  always @(posedge Clk)
    n814 <= n813;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:18 */
  assign n815 = ~n332;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:169:18 */
  assign n816 = n434 & n815;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n817 = y[7:0]; // extract
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n818 = n816 ? alu_q : n817;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  always @(posedge Clk)
    n819 <= n818;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  always @(posedge Clk or posedge n332)
    if (n332)
      n820 <= 8'b00000000;
    else
      n820 <= n450;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n821 = n568 ? n554 : ad;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n822 <= 8'b00000000;
    else
      n822 <= n821;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n823 = n569 ? n553 : dl;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n824 <= 8'b00000000;
    else
      n824 <= n823;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n825 = n570 ? n558 : bah;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n826 <= 8'b00000000;
    else
      n826 <= n825;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n827 = n571 ? n562 : bal;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n828 <= 9'b000000000;
    else
      n828 <= n827;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n829 = n252 ? 8'b11111111 : pbr;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n830 <= 8'b00000000;
    else
      n830 <= n829;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n831 = n253 ? 8'b11111111 : dbr;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n832 <= 8'b00000000;
    else
      n832 <= n831;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n833 = n254 ? n234 : pc;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n834 <= 16'b0000000000000000;
    else
      n834 <= n833;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n835 = n255 ? n185 : s;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n836 <= 16'b0000000000000000;
    else
      n836 <= n835;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n837 = n256 ? 1'b0 : ef_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n838 <= 1'b1;
    else
      n838 <= n837;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n839 = n257 ? 1'b0 : mf_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n840 <= 1'b1;
    else
      n840 <= n839;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n841 = n258 ? 1'b0 : xf_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n842 <= 1'b1;
    else
      n842 <= n841;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n843 = n259 ? n150 : ir;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n844 <= 8'b00000000;
    else
      n844 <= n843;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n845 = n771 ? n737 : mcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk or posedge n730)
    if (n730)
      n846 <= 3'b001;
    else
      n846 <= n845;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n847 = n260 ? Mode : mode_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n848 <= 2'b00;
    else
      n848 <= n847;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n849 = n261 ? BCD_en : bcd_en_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n850 <= 1'b1;
    else
      n850 <= n849;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n851 = n262 ? alu_op : alu_op_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n852 <= 5'b01100;
    else
      n852 <= n851;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n853 = n263 ? write_data : write_data_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n854 <= 4'b0000;
    else
      n854 <= n853;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n855 = n264 ? n172 : set_addr_to_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n856 <= 2'b00;
    else
      n856 <= n855;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n857 = n772 ? 1'b0 : rstcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk or posedge n730)
    if (n730)
      n858 <= 1'b1;
    else
      n858 <= n857;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n859 = n265 ? n155 : irqcycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n860 <= 1'b0;
    else
      n860 <= n859;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n861 = n266 ? n159 : nmicycle;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n862 <= 1'b0;
    else
      n862 <= n861;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n863 = n773 ? n758 : irqreq;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk or posedge n730)
    if (n730)
      n864 <= 1'b0;
    else
      n864 <= n863;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n865 = n774 ? n751 : nmireq;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk or posedge n730)
    if (n730)
      n866 <= 1'b0;
    else
      n866 <= n865;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:200:10 */
  assign n867 = ~n332;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  assign n868 = n867 ? SO_n : so_n_o;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:457:5 */
  always @(posedge Clk)
    n869 <= n868;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:201:10 */
  assign n870 = ~n730;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:201:10 */
  assign n871 = Enable & n870;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n872 = n871 ? IRQ_n : irq_n_o;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk)
    n873 <= n872;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:202:10 */
  assign n874 = ~n730;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:202:10 */
  assign n875 = Enable & n874;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n876 = n875 ? NMI_n : nmi_n_o;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk)
    n877 <= n876;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  assign n878 = Enable ? n770 : nmiact;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:682:5 */
  always @(posedge Clk or posedge n730)
    if (n730)
      n879 <= 1'b0;
    else
      n879 <= n878;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n880 = n572 ? busa : busa_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n881 <= 8'b00000000;
    else
      n881 <= n880;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n882 = n573 ? DI : busb;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n883 <= 8'b00000000;
    else
      n883 <= n882;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n884 = n574 ? n475 : busb_r;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk or posedge n467)
    if (n467)
      n885 <= 8'b00000000;
    else
      n885 <= n884;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:333:5 */
  always @(posedge Clk or posedge n105)
    if (n105)
      n886 <= 1'b0;
    else
      n886 <= res_n_d;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:333:5 */
  always @(posedge Clk or posedge n105)
    if (n105)
      n887 <= 1'b0;
    else
      n887 <= 1'b1;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:246:10 */
  assign n888 = ~n117;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:246:10 */
  assign n889 = Enable & n888;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n890 = n889 ? n137 : rdy_mod;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk)
    n891 <= n890;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  assign n892 = n268 ? n139 : wrn_i;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:362:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n893 <= 1'b1;
    else
      n893 <= n892;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:250:10 */
  assign n894 = ~n467;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:250:10 */
  assign n895 = n575 & n894;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  assign n896 = n895 ? n550 : nmi_entered;
  /*# /Users/scottmoschella/work/supersprint/modules/cpu-t65/T65.vhd:542:5 */
  always @(posedge Clk)
    n897 <= n896;
endmodule

