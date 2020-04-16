function cmap = cm_phase(varargin)

% CM_PHASE: 256 color palette from CMOCEAN
%
% cmap = cm_phase(M)
%
% PHASE colormap by Kristen Thyng.
%
% On Input:
%
%    M        Number of colors (integer, OPTIONAL)
%
% On Ouput:
%
%    cmap     Mx3 colormap matrix
%
% Usage:
%
%    colormap(cm_phase)
%    colormap(flipud(cm_phase))
%
% https://github.com/matplotlib/cmocean/tree/master/cmocean/rgb
%
% Thyng, K.M., C.A. Greene, R.D. Hetland, H.M. Zimmerle, and S.F DiMarco, 2016:
%   True colord of oceanography: Guidelines for effective and accurate colormap
%   selection, Oceanography, 29(3), 9-13, http://dx.doi.org/10.5670/oceanog.2016.66 
% 

% svn $Id$

% Initialize.

switch numel(varargin)
  case 0
    M = 256;
  case 1
    M = varargin{1};
end

% Set 256 colormap.

cmap = [[6.583083928922510708e-01, 4.699391690315133929e-01, 4.941288203988051381e-02],
        [6.643374189373471017e-01, 4.662019008569991407e-01, 5.766473450402211792e-02],
        [6.702086925052345157e-01, 4.624801381219734719e-01, 6.534560309537773559e-02],
        [6.760429905334627287e-01, 4.586983759956768103e-01, 7.273174322210870790e-02],
        [6.817522846284524984e-01, 4.549140651836585669e-01, 7.979261956680192003e-02],
        [6.874028047282801923e-01, 4.510841669914616436e-01, 8.667102950867147659e-02],
        [6.929504980948593129e-01, 4.472389296506211198e-01, 9.335868960148416273e-02],
        [6.984261912087648128e-01, 4.433576785927097474e-01, 9.992839268327721736e-02],
        [7.038122981036579739e-01, 4.394532762349419586e-01, 1.063871045640915336e-01],
        [7.091206923190102041e-01, 4.355176525107516405e-01, 1.127717449252612913e-01],
        [7.143452449012380745e-01, 4.315557562030358230e-01, 1.190934789448820086e-01],
        [7.194928861674689813e-01, 4.275627171694253437e-01, 1.253760590955056708e-01],
        [7.245561927479047259e-01, 4.235446971269447580e-01, 1.316232516304018385e-01],
        [7.295489482895208821e-01, 4.194909849233816046e-01, 1.378630483492892522e-01],
        [7.344517242247444733e-01, 4.154177405103107734e-01, 1.440803933719045082e-01],
        [7.392949550641365608e-01, 4.112997327023164562e-01, 1.503221736968965161e-01],
        [7.440383351241327547e-01, 4.071715772870146410e-01, 1.565433461845777419e-01],
        [7.487369523694534790e-01, 4.029851907815384382e-01, 1.628228161295872112e-01],
        [7.533231937521204236e-01, 3.988010690198531272e-01, 1.690756638056752914e-01],
        [7.578808294584169492e-01, 3.945424511336589335e-01, 1.754217924072464518e-01],
        [7.623326022156785564e-01, 3.902809567197497165e-01, 1.817591538530497208e-01],
        [7.667320478995347521e-01, 3.859654943537603744e-01, 1.881681875043557384e-01],
        [7.710524721820763983e-01, 3.816214148216601210e-01, 1.946153193576832252e-01],
        [7.752952778457107286e-01, 3.772473246523442292e-01, 2.011065208945331251e-01],
        [7.794866593781552000e-01, 3.728150850100374614e-01, 2.076872953652798559e-01],
        [7.835853362619955575e-01, 3.683677247727679127e-01, 2.142973641992331202e-01],
        [7.876376313731141554e-01, 3.638539950288945946e-01, 2.210164757476915653e-01],
        [7.916113385801130109e-01, 3.593080404226161040e-01, 2.277974012097270795e-01],
        [7.955060552511121763e-01, 3.547298979176854994e-01, 2.346435260251332755e-01],
        [7.993539838133075781e-01, 3.500795929482780067e-01, 2.416183193481767355e-01],
        [8.031167084780931331e-01, 3.454015163918872089e-01, 2.486589162182153978e-01],
        [8.068103261859892461e-01, 3.406745225101673324e-01, 2.558007514596662979e-01],
        [8.104452043001210138e-01, 3.358824841311982556e-01, 2.630722168071251699e-01],
        [8.139968010634672790e-01, 3.310553831960054150e-01, 2.704318260711638389e-01],
        [8.174768947816700715e-01, 3.261752637674419919e-01, 2.779109619017897659e-01],
        [8.208941481936247175e-01, 3.212262889577221503e-01, 2.855384604486080891e-01],
        [8.242271261613036692e-01, 3.162361985850312696e-01, 2.932761677775464482e-01],
        [8.274766137520660481e-01, 3.112015433453460544e-01, 3.011338788484150264e-01],
        [8.306639856730879679e-01, 3.060845940504859919e-01, 3.091757851828964565e-01],
        [8.337630658888238733e-01, 3.009224359536462057e-01, 3.173492086215453090e-01],
        [8.367728587568070697e-01, 2.957134612590129330e-01, 3.256619937531243236e-01],
        [8.396969301670653696e-01, 2.904472328682123905e-01, 3.341366497709652439e-01],
        [8.425387334318170662e-01, 2.851115076990556330e-01, 3.427996193346179443e-01],
        [8.452829693062083871e-01, 2.797291658336165110e-01, 3.516207809735176215e-01],
        [8.479270414576970394e-01, 2.743004518168249417e-01, 3.606068061808916925e-01],
        [8.504679257105771661e-01, 2.688262350691851821e-01, 3.697639476988339724e-01],
        [8.529105574510703613e-01, 2.632885874038991547e-01, 3.791311611530527870e-01],
        [8.552420044048544279e-01, 2.577088839643039142e-01, 3.886821696092926381e-01],
        [8.574567263211506640e-01, 2.520936658861107627e-01, 3.984160108673813205e-01],
        [8.595502320723124035e-01, 2.464473708549377862e-01, 4.083362533435646036e-01],
        [8.615176695665305306e-01, 2.407756349505418836e-01, 4.184455712413106543e-01],
        [8.633539245616504987e-01, 2.350852138633325872e-01, 4.287460573240959860e-01],
        [8.650568452189218993e-01, 2.293728768111193417e-01, 4.392600781097817930e-01],
        [8.666160631462880293e-01, 2.236630759123471868e-01, 4.499612660389528673e-01],
        [8.680257787196800079e-01, 2.179678524813165597e-01, 4.608475800597766070e-01],
        [8.692800281403405549e-01, 2.123013227323138907e-01, 4.719155444862356830e-01],
        [8.703727414475561641e-01, 2.066798807505955682e-01, 4.831601540690036445e-01],
        [8.712978068076887572e-01, 2.011223984119477337e-01, 4.945747939602412324e-01],
        [8.720491402648608004e-01, 1.956504128743852822e-01, 5.061511790861612514e-01],
        [8.726207597696474805e-01, 1.902882889012951495e-01, 5.178793172539123413e-01],
        [8.730068619526127893e-01, 1.850633392111822872e-01, 5.297474998646168887e-01],
        [8.732018998073337590e-01, 1.800058813906028066e-01, 5.417423233741458510e-01],
        [8.732006592202997686e-01, 1.751492049740893675e-01, 5.538487436526324803e-01],
        [8.729983321570818910e-01, 1.705294177324829519e-01, 5.660501641838993070e-01],
        [8.725905843033689990e-01, 1.661851370964102237e-01, 5.783285576821829421e-01],
        [8.719736126526835829e-01, 1.621569796196943858e-01, 5.906646606873059424e-01],
        [8.711441430703839028e-01, 1.584866680756561452e-01, 6.030388085538075371e-01],
        [8.700996606911847175e-01, 1.552168662477456385e-01, 6.154284378630663355e-01],
        [8.688382315166471859e-01, 1.523889228568965915e-01, 6.278117548576560569e-01],
        [8.673585803491290491e-01, 1.500419870434277214e-01, 6.401665059420836856e-01],
        [8.656600953609360216e-01, 1.482114935188816873e-01, 6.524702171100530412e-01],
        [8.637428203708292784e-01, 1.469276207331668138e-01, 6.647004334019646077e-01],
        [8.616074355850228406e-01, 1.462138565700954185e-01, 6.768349518289993316e-01],
        [8.592552279602999610e-01, 1.460858181738819150e-01, 6.888520417478360969e-01],
        [8.566880526588371847e-01, 1.465504601378146143e-01, 7.007306474947510022e-01],
        [8.539082940810565070e-01, 1.476057634824317899e-01, 7.124505416663439172e-01],
        [8.509188132430276497e-01, 1.492409439214724132e-01, 7.239924974090546916e-01],
        [8.477228732160004832e-01, 1.514371672020923265e-01, 7.353384896921373315e-01],
        [8.443240935674275471e-01, 1.541686506679828816e-01, 7.464717393223647690e-01],
        [8.407263939629991967e-01, 1.574040314553000475e-01, 7.573767829039294019e-01],
        [8.369339386719339968e-01, 1.611078555520196187e-01, 7.680395184197363889e-01],
        [8.329510832270686782e-01, 1.652420527841307607e-01, 7.784472273410004695e-01],
        [8.287823240288615390e-01, 1.697672910052525075e-01, 7.885885755886976600e-01],
        [8.244322514509230260e-01, 1.746441391323516057e-01, 7.984535959358352031e-01],
        [8.199055067926670493e-01, 1.798340046929527702e-01, 8.080336545530442116e-01],
        [8.152067432395495583e-01, 1.852998414406232253e-01, 8.173214043862717659e-01],
        [8.103405908369269994e-01, 1.910066437572490727e-01, 8.263107279415592421e-01],
        [8.053117579051806141e-01, 1.969216010609510237e-01, 8.349964504885767358e-01],
        [8.001246695316600599e-01, 2.030146524204510805e-01, 8.433748621071933682e-01],
        [7.947836730093801316e-01, 2.092582614636481764e-01, 8.514431956464665330e-01],
        [7.892930180385833161e-01, 2.156273737159832282e-01, 8.591995655348122485e-01],
        [7.836568069717744223e-01, 2.220993550443281506e-01, 8.666429444356050782e-01],
        [7.778789796122015376e-01, 2.286538551089048465e-01, 8.737730828797295457e-01],
        [7.719633002465959848e-01, 2.352726496465096795e-01, 8.805904299224873721e-01],
        [7.659133466040326521e-01, 2.419394735315277267e-01, 8.870960555269299386e-01],
        [7.597325004651533931e-01, 2.486398530394249295e-01, 8.932915751926430170e-01],
        [7.534239396834068181e-01, 2.553609429642716422e-01, 8.991790771963389384e-01],
        [7.469906314200031039e-01, 2.620913721366889826e-01, 9.047610526867282399e-01],
        [7.404353264352245834e-01, 2.688210993418901351e-01, 9.100403287788533246e-01],
        [7.337605543192734503e-01, 2.755412805372748908e-01, 9.150200047193097763e-01],
        [7.269686195850667554e-01, 2.822441475132592692e-01, 9.197033911407090923e-01],
        [7.200615985827201193e-01, 2.889228976436723495e-01, 9.240939523881464002e-01],
        [7.130413372306516617e-01, 2.955715940634778272e-01, 9.281952518796100504e-01],
        [7.059094495911268918e-01, 3.021850754377659598e-01, 9.320109004535763741e-01],
        [6.986673173487639721e-01, 3.087588744057577217e-01, 9.355445076582962205e-01],
        [6.913160902792203633e-01, 3.152891437666022756e-01, 9.387996359465969887e-01],
        [6.838566878221142842e-01, 3.217725894980000279e-01, 9.417797577558794098e-01],
        [6.762898018976056802e-01, 3.282064097483991527e-01, 9.444882154741288671e-01],
        [6.686159011300095711e-01, 3.345882390078672719e-01, 9.469281843183131597e-01],
        [6.608352366648267973e-01, 3.409160967342457216e-01, 9.491026381806494383e-01],
        [6.529478497874137144e-01, 3.471883397852293385e-01, 9.510143185305323099e-01],
        [6.449535815726188392e-01, 3.534036180803885596e-01, 9.526657064947888776e-01],
        [6.368520848146350666e-01, 3.595608329884161236e-01, 9.540589982761437104e-01],
        [6.286428385050449874e-01, 3.656590980031973470e-01, 9.551960841088614762e-01],
        [6.203251651440072623e-01, 3.716977013375789007e-01, 9.560785309910512231e-01],
        [6.118982511841425387e-01, 3.776760701263490727e-01, 9.567075694743777392e-01],
        [6.033611709179768079e-01, 3.835937359904362243e-01, 9.570840848332117234e-01],
        [5.947129141266446206e-01, 3.894503017735960748e-01, 9.572086129751365968e-01],
        [5.859524178083830304e-01, 3.952454093215529429e-01, 9.570813414919564499e-01],
        [5.770786022984990549e-01, 4.009787082326203289e-01, 9.567021162826109260e-01],
        [5.680904120756430364e-01, 4.066498255689147689e-01, 9.560704542043091392e-01],
        [5.589868615201727398e-01, 4.122583365789312393e-01, 9.551855622225308151e-01],
        [5.497670858464057675e-01, 4.178037365457583641e-01, 9.540463635305430623e-01],
        [5.404303973688802110e-01, 4.232854139404694238e-01, 9.526515310905910860e-01],
        [5.309763471805271084e-01, 4.287026251268353794e-01, 9.509995290068892215e-01],
        [5.214047922154096959e-01, 4.340544709302417981e-01, 9.490886620701871612e-01],
        [5.117159675380545947e-01, 4.393398754490472347e-01, 9.469171337096092822e-01],
        [5.019105635439048418e-01, 4.445575675481795996e-01, 9.444831124449268867e-01],
        [4.919898075708288299e-01, 4.497060655293146358e-01, 9.417848067474301477e-01],
        [4.819555492105473404e-01, 4.547836655159373520e-01, 9.388205479873396042e-01],
        [4.718103483745911819e-01, 4.597884341201938230e-01, 9.355888808698555881e-01],
        [4.615575649166388517e-01, 4.647182059669867082e-01, 9.320886604427106592e-01],
        [4.511980082251949020e-01, 4.695721776839077433e-01, 9.283178636903177683e-01],
        [4.407385246316099514e-01, 4.743468819302843476e-01, 9.242766906682317041e-01],
        [4.301872191964954406e-01, 4.790386406828319177e-01, 9.199661970019400448e-01],
        [4.195516590423077341e-01, 4.836443962749994996e-01, 9.153875906397229700e-01],
        [4.088406331006777528e-01, 4.881609386110861704e-01, 9.105429315654867128e-01],
        [3.980642083018061106e-01, 4.925849423947825101e-01, 9.054352272162426996e-01],
        [3.872337717548847147e-01, 4.969130108713233906e-01, 9.000685170373873278e-01],
        [3.763620564988861550e-01, 5.011417254753421924e-01, 8.944479427537497251e-01],
        [3.654612663762428770e-01, 5.052684034325813922e-01, 8.885787674719856089e-01],
        [3.545465439790672080e-01, 5.092897968880314430e-01, 8.824681923036010733e-01],
        [3.436377931849474154e-01, 5.132015795889635079e-01, 8.761266360928694485e-01],
        [3.327530939137686161e-01, 5.170008198204416594e-01, 8.695640864822369309e-01],
        [3.219116583925260011e-01, 5.206848733578030020e-01, 8.627916585616799416e-01],
        [3.111337198622898259e-01, 5.242514414427805747e-01, 8.558215206665023000e-01],
        [3.004403986093719392e-01, 5.276986238157412856e-01, 8.486667948769511804e-01],
        [2.898532566310526581e-01, 5.310250549915590534e-01, 8.413412305522999235e-01],
        [2.793961594244663282e-01, 5.342293148180886631e-01, 8.338605094653681604e-01],
        [2.690918119759744820e-01, 5.373109871573702456e-01, 8.262398418700288572e-01],
        [2.589630009926549015e-01, 5.402702010433201307e-01, 8.184947475296583397e-01],
        [2.490323931623479869e-01, 5.431076290262466522e-01, 8.106408952154365855e-01],
        [2.393222899575573326e-01, 5.458244839403564308e-01, 8.026939223701164972e-01],
        [2.298566351816503373e-01, 5.484218890000336355e-01, 7.946712158983202379e-01],
        [2.206551002944838191e-01, 5.509024141956824216e-01, 7.865870626923798792e-01],
        [2.117364094415158937e-01, 5.532690129113547739e-01, 7.784553296976853831e-01],
        [2.031184306485467883e-01, 5.555248911915373622e-01, 7.702897347110843063e-01],
        [1.948172015035146420e-01, 5.576736467032974431e-01, 7.621031776295352778e-01],
        [1.868465966290397962e-01, 5.597192229650957973e-01, 7.539076339343501187e-01],
        [1.792179884783634825e-01, 5.616658613090964591e-01, 7.457140662049784874e-01],
        [1.719421959020442647e-01, 5.635174702399022850e-01, 7.375349843171632447e-01],
        [1.650229512673002386e-01, 5.652791533635259658e-01, 7.293775439873284583e-01],
        [1.584611602813638387e-01, 5.669560017699032395e-01, 7.212481886261494779e-01],
        [1.522549918213680353e-01, 5.685529672520610589e-01, 7.131532051881548373e-01],
        [1.463987618681510117e-01, 5.700750569206646245e-01, 7.050976866560473288e-01],
        [1.408828405908224835e-01, 5.715272914520931336e-01, 6.970855353349069139e-01],
        [1.356936625367466953e-01, 5.729146658465781305e-01, 6.891194758268863740e-01],
        [1.308138525417579801e-01, 5.742421127377883572e-01, 6.812010763134157543e-01],
        [1.262224734293325157e-01, 5.755144682058210837e-01, 6.733307769330967307e-01],
        [1.218953938035638729e-01, 5.767364399826563348e-01, 6.655079242329828837e-01],
        [1.178065439715534068e-01, 5.779123523036159282e-01, 6.577323260140637284e-01],
        [1.139261298009009160e-01, 5.790467957802227783e-01, 6.499998366451625875e-01],
        [1.102234782385779766e-01, 5.801439808367224726e-01, 6.423063681141680803e-01],
        [1.066673235183970281e-01, 5.812078215483343913e-01, 6.346473314887408623e-01],
        [1.032263067644274834e-01, 5.822419757773840132e-01, 6.270172879951815270e-01],
        [9.986970116659238395e-02, 5.832498248631478033e-01, 6.194100074982554771e-01],
        [9.656813269866712512e-02, 5.842344549012296051e-01, 6.118185305845139643e-01],
        [9.329429206118067253e-02, 5.851986396650793454e-01, 6.042352341768219004e-01],
        [9.002364276931534848e-02, 5.861448252640329981e-01, 5.966519005456781821e-01],
        [8.673514013646366205e-02, 5.870751166646858143e-01, 5.890597894857422245e-01],
        [8.341198598223345528e-02, 5.879912662222103181e-01, 5.814497133016774955e-01],
        [8.004245400348602990e-02, 5.888946643728962815e-01, 5.738121141059205899e-01],
        [7.662083060590932360e-02, 5.897863326271246542e-01, 5.661371427838456372e-01],
        [7.314852485397654869e-02, 5.906669189727291602e-01, 5.584147388414824054e-01],
        [6.963540714651897390e-02, 5.915366957529474279e-01, 5.506347102299997687e-01],
        [6.610143501147561218e-02, 5.923955600227664986e-01, 5.427868121514007882e-01],
        [6.257860760091599195e-02, 5.932430363153763375e-01, 5.348608238014407323e-01],
        [5.911303759975024968e-02, 5.940783314685343930e-01, 5.268461376019544229e-01],
        [5.576765010285392871e-02, 5.949002975004614724e-01, 5.187321979872163702e-01],
        [5.262510565424809855e-02, 5.957073200832398996e-01, 5.105097808257538228e-01],
        [4.978880680939656161e-02, 5.964975038111670624e-01, 5.021693595319391967e-01],
        [4.738319269394732774e-02, 5.972686215557058143e-01, 4.937017361708459506e-01],
        [4.555066847662456869e-02, 5.980181252952141424e-01, 4.850980867717663014e-01],
        [4.444396189302631667e-02, 5.987431566697054564e-01, 4.763500004038906943e-01],
        [4.421322948900235222e-02, 5.994405566877633040e-01, 4.674495124401222834e-01],
        [4.498917867710291313e-02, 6.001068740129568146e-01, 4.583891327826852824e-01],
        [4.686604485069371245e-02, 6.007383712762072170e-01, 4.491618701849053319e-01],
        [4.988979024235475762e-02, 6.013310288983726437e-01, 4.397612541729841729e-01],
        [5.405573006313083712e-02, 6.018805543938667846e-01, 4.301812015738862294e-01],
        [5.932208540209162745e-02, 6.023828876312081748e-01, 4.204054325617814780e-01],
        [6.560773880422715587e-02, 6.028325831369402144e-01, 4.104377156032376628e-01],
        [7.281962363892094392e-02, 6.032244155970721833e-01, 4.002736262351211383e-01],
        [8.086176781346332554e-02, 6.035528335053932381e-01, 3.899094149354802585e-01],
        [8.964365767756551917e-02, 6.038119404209635332e-01, 3.793420777858104165e-01],
        [9.908952486975769469e-02, 6.039955435016706176e-01, 3.685641184021282157e-01],
        [1.091461686387718844e-01, 6.040969460876761676e-01, 3.575579876882719055e-01],
        [1.197411868235576382e-01, 6.041085844094219448e-01, 3.463409605502589250e-01],
        [1.308274635712054768e-01, 6.040228036354146068e-01, 3.349141605174003056e-01],
        [1.423800347596975990e-01, 6.038311914501962585e-01, 3.232669997463486489e-01],
        [1.543847008629261053e-01, 6.035242532835117801e-01, 3.113882295486853913e-01],
        [1.667909278439370091e-01, 6.030930063069259717e-01, 2.993102878563658198e-01],
        [1.795975741928860503e-01, 6.025266800569213377e-01, 2.870237044475537069e-01],
        [1.927996570161342460e-01, 6.018136381688595771e-01, 2.745296424849442141e-01],
        [2.063446461864067438e-01, 6.009446614046377588e-01, 2.618794002040416569e-01],
        [2.202728729725795254e-01, 5.999042993738278318e-01, 2.490425136645111337e-01],
        [2.344983329249494819e-01, 5.986859114745567423e-01, 2.361102156981361166e-01],
        [2.490441577314199684e-01, 5.972745984023483112e-01, 2.230778046167814499e-01],
        [2.638200588853058526e-01, 5.956665601719514092e-01, 2.100467332369221340e-01],
        [2.788103972435367339e-01, 5.938520960352462463e-01, 1.970548426870546432e-01],
        [2.939149436021079032e-01, 5.918334783865150106e-01, 1.842162055743405413e-01],
        [3.090633958032663053e-01, 5.896130197890373514e-01, 1.716194213262129398e-01],
        [3.241557701146778325e-01, 5.872013194176191053e-01, 1.593775348465770181e-01],
        [3.391058987925449908e-01, 5.846116417760637285e-01, 1.475901239657965436e-01],
        [3.537962403050050608e-01, 5.818679304916246631e-01, 1.363773405186440579e-01],
        [3.681790539934771678e-01, 5.789861015095073560e-01, 1.258005415905540103e-01],
        [3.821596573789931561e-01, 5.759951191731197406e-01, 1.159503977992311363e-01],
        [3.957282445230750900e-01, 5.729092809436007183e-01, 1.068503820674790161e-01],
        [4.088192648913888116e-01, 5.697572697905517458e-01, 9.855521202608327758e-02],
        [4.214810649035653500e-01, 5.665415862717396722e-01, 9.104002246571415990e-02],
        [4.336495334558000403e-01, 5.632929561600926727e-01, 8.434116239111955071e-02],
        [4.453890783516751273e-01, 5.600085906382493706e-01, 7.841305443909030171e-02],
        [4.567242130853677584e-01, 5.566942951475172263e-01, 7.322913012508130981e-02],
        [4.676501707681009479e-01, 5.533637269053324204e-01, 6.876762134759795142e-02],
        [4.781913781821610088e-01, 5.500213008191600084e-01, 6.498435721988443659e-02],
        [4.883968612384750885e-01, 5.466619506976900800e-01, 6.182162837413415074e-02],
        [4.982892398787829857e-01, 5.432873953595327432e-01, 5.922725775013665955e-02],
        [5.078911374422868663e-01, 5.398982668933685058e-01, 5.714465998451528223e-02],
        [5.172247456455653092e-01, 5.364942872197172585e-01, 5.551476288204022086e-02],
        [5.263115025893324583e-01, 5.330744300746458331e-01, 5.427792556635833293e-02],
        [5.351718645250624906e-01, 5.296370658817842747e-01, 5.337566853443905662e-02],
        [5.438251536372012973e-01, 5.261800887043684982e-01, 5.275207547378853862e-02],
        [5.522894663786476199e-01, 5.227010255649303661e-01, 5.235479075452074277e-02],
        [5.605816294780567866e-01, 5.191971290183284848e-01, 5.213559944466891055e-02],
        [5.687171933168381210e-01, 5.156654540879882509e-01, 5.205062439450063722e-02],
        [5.767104547724090091e-01, 5.121029206313181259e-01, 5.206020204364426168e-02],
        [5.845745037500035268e-01, 5.085063619725217476e-01, 5.212850674796504907e-02],
        [5.923212894447653643e-01, 5.048725602928031408e-01, 5.222298774900729218e-02],
        [5.999617038945115333e-01, 5.011982688438658684e-01, 5.231366903560310394e-02],
        [6.075056816322426112e-01, 4.974802205790658793e-01, 5.237234455720112675e-02],
        [6.149623152735116394e-01, 4.937151222923196747e-01, 5.237168182411356537e-02],
        [6.223399877334323538e-01, 4.898996328220020513e-01, 5.228422613133864444e-02],
        [6.296465225194588511e-01, 4.860303233135512824e-01, 5.208127381405584094e-02],
        [6.368893542334475022e-01, 4.821036169426133333e-01, 5.173155232549151578e-02],
        [6.440757220432393737e-01, 4.781157049081125598e-01, 5.119960076823739520e-02],
        [6.512128893528150719e-01, 4.740624350126631525e-01, 5.044367478760234530e-02],
        [6.583083928921535932e-01, 4.699391690315524728e-01, 4.941288204103298082e-02]];

% Interpolate to requested number of colors.

P = size(cmap,1);

if (P ~= M)
  cmap = interp1(1:size(cmap,1), cmap, linspace(1,P,M), 'linear');
end

return
