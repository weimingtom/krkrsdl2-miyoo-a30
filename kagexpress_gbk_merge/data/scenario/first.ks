@call storage="snow.ks"
; �� ѩ plug-in ���i���z��
@wait time=200

@eval exp="f.bg=''"
; ���F���i���z�ޤ�Ƥ��뱳����ӛ�����Ƥ���

; �ޥ��� changebg_and_clear �ζ��x
@macro name="changebg_and_clear"
@if exp="mp.storage != f.bg"
; ���Ȥ��i���z�ޤ�Ƥ��뱳����ͬ���ʤ���Ф��椨�I����Ф�ʤ�
@eval exp="f.bg = mp.storage"
@backlay
@layopt layer=message0 page=back visible=false
@trans method=crossfade time=300
@wt
@image * layer=base page=back
@trans method=crossfade time=300
@wt
@cm
@layopt layer=message0 page=back visible=true
@trans method=crossfade time=300
@wt
@endif
@endmacro

; �ޥ��� loadbg �ζ��x
@macro name="loadbg"
@image * layer=base
@eval exp="f.bg = mp.storage"
@endmacro

; �ޥ��� start_select �ζ��x
@macro name="start_select"
@backlay
@nowait
@history output=false
@current page=back
@endmacro

; �ޥ��� end_select �ζ��x
@macro name="end_select"
@trans method=crossfade time=400
@wt
@endnowait
@history output=true
@current page=fore
@endmacro

*syokai_start|���Ｊ���KAG�νB�� - ��˥�`
@startanchor

; �����˻�����i���z�ߡ���å��`���쥤��˥�˥�`���軭
@backlay
@loadbg storage="_24_5" page=back
@current page=back
@cm
@layopt layer=message0 page=back visible=true
@nowait
@history output=false
@style align=center
[font size=40 color=0x00ffff]���Ｊ���KAG�νB��[resetfont][r]
[r]
[link target="*about_kirikiri"]���Ｊ��Ȥ�[endlink][r]
[link target="*about_kag"]KAG�Ȥ�[endlink][r]
[r]
[r]
[r]
[r]
[r]
[r]
[r]
[link exp="kag.shutdown()" color=0xff0000 hint="���Ｊ��/KAG�νB���K�ˤ��ޤ�"]�K��[endlink]
@endnowait
@history output=true
@current page=fore

; ��å��`���쥤��Υȥ�󥸥����
@trans method=crossfade time=800
@wt

; ͨ�^ӛ�h
@record

; �x�k֫���x�k�����ޤ�ֹͣ
@s

*to_syokai_start
; syokai_start �ˑ���
@backlay
@layopt layer=message0 page=back visible=false
@trans method=crossfade time=300
@wt
@jump target=*syokai_start


*about_kirikiri|���Ｊ��Ȥ�
@changebg_and_clear storage="_24_4"
�����Ｊ��ϡ�TJS�Ȥ���������ץ����Z��ʹ�äƤ�������¤򤹤뤿��Υ��եȥ������Ǥ���[l][r]
��TJS��Java��JavaScript���㤷�ƣ��Ǹ�ä��褦�����Z�ǡ�C��C++�˱Ȥ٤�����ä��䤹�����Z����˼���ޤ���[l][r]
�����Ｊ��ǤϤ���TJS�Ǳ�����������뤳�Ȥˤ�ꡢ���ޤ��ޤʥ��ץꥱ�`���������ɤ��뤳�Ȥ��Ǥ��ޤ���[l][r]
���ؤ˥ޥ����ǥ���ϵ�ΙC�ܤ����������^�ľ��Ĥʱ�F���ä��룲�ĥ��`����m���Ƥ��ޤ���[p]
*about_kirikiri2|
@cm
�����Ｊ��ϡ��쥤��Ⱥ��Ф�뻭����ö���ؤͺϤ碌�ƻ���򘋳ɤ��ޤ���[l]�쥤��ϥ���ե��֥��ɤˤ���ؤͺϤ碌�����ܤǡ��A�Ә�����뤳�Ȥ�Ǥ��ޤ���[l][r]
���쥤��ˤϘ˜ʤ�PNG/JPEG/ERI/BMP���i���z�߿��ܤǡ�Susie-plugin���i���z�߿��ܤ���ʽ�򒈏����뤳�Ȥ�Ǥ��ޤ���[l][r]
���軭�Ϥ��ޤ��}�j�ʤ��ȤϤǤ��ޤ��󤬡���͸�����Τ��軭�䥢��������ꥢ�����ܤ����ֱ�ʾ������Β���sС����Τ��Ф��¤��Ǥ��ޤ���[l][r]
��AVI/MPEG��SWF(Macromedia Flash)���`�ө`�Ȥ������������뤳�Ȥ��Ǥ��ޤ���[p]
*about_kirikiri3|
@cm
�����Ｊ��Ǥ�CD-DA��MIDI���`���󥹥ǩ`����PCM�����������뤳�Ȥ��Ǥ������줾�������{�������ܤǤ���[l]PCM�ϟo�R�s��.WAV�ե�����Τۤ����ץ饰������������ܤ���ʽ�򒈏��Ǥ���OggVorbis���������뤳�Ȥ��Ǥ��ޤ���[l][r]
��PCM���}����ͬ�r���������뤳�Ȥ��Ǥ��ޤ���[l]CD-DA��MIDI���`���󥹥ǩ`���Ǥ�o��ʸ������˼�����}��ͬ�r�����Ǥ��ޤ���[p]
*about_kirikiri4
@cm
�������������x�ĩ`��Ȥ��ơ�
�}���Υե������һ�ĤˤޤȤ᤿�ꡢ�g��ǌg�п��ܤʥե���������ɤ��뤳�Ȥ��Ǥ���[font color=0xffff00]Releaser[resetfont]��[l]
���Ｊ�ﱾ����O�����Ф�[font color=0xffff00]���Ｊ���O��[resetfont]��[l]
�����߂Ȥǥե���Ȥ����⤷���ץ�`��Ȥ˥ե���Ȥ����󥹥ȩ`�뤵��Ɵo���Ƥ�ʹ����褦�ˤ���[font color=0xffff00]������󥰜g�ߥե�������ɥĩ`��[resetfont]��[l]
͸���Ȥ�֤ä�����ե��`�ޥå��g���໥��Q���Ф�[font color=0xffff00]͸�^����ե��`�ޥåȥ���Щ`��[resetfont]������ޤ���[l]
[r]
[r]
@start_select
[link target=*to_syokai_start]��˥�`�ˑ���[endlink]
@end_select
[s]

*about_kag|KAG�Ȥ�
@changebg_and_clear storage="_24_4"
��KAG�ϡ��ӥ��𥢥�Υ٥�䥵����ɥΥ٥�Τ褦�ʥΥ٥�ϵ���`��䡢�x�k֫���x��ǥ��ȩ`��`���M��褦�����֥٩`���Υ��ɥ٥����`���`������ɤ��뤿��Υ��åȤǤ���[l][r]
��KAG�ϼ��Ｊ��򥲩`�२�󥸥�Ȥ��Ƅ��������뤿��Υ�����ץȤǡ����������TJS������ץȤǕ�����Ƥ��ޤ���[l]KAG�äΥ�����ץȤϡ����ʥꥪ���Ⱥ��Ф졢TJS������ץȤȤϤޤ��e�Τ�ΤǤ���[l]TJS������ץȤϥץ���ߥ󥰤�֪�R�����ʤ��Ҫ�ˤʤ�ޤ��������ʥꥪ�Ϥ�꺆�g��ӛ�����䤹����ΤǤ���[l][r]
��KAG�ϼ��Ｊ����Ϥ˳ɤ����ĥ����ƥ�ʤΤǡ����Ｊ��ΙC�ܤΤۤȤ�ɤ�KAG��ʹ�äǤ��ޤ���[p]
*about_kag3|
@cm
��KAG�����ֱ�ʾ�ϡ����E��ͨ��Υ���������ꥢ�����ֱ�ʾ�˼Ӥ���[l][r]
[font size=60]�󤭤�����[resetfont]���ʾ�����ꡢ[l][r]
[ruby text="��"]��[ruby text="��"]��[ruby text="��"]��[ruby text="��"]��[ruby text="��"]��[ruby text="��"]��[ruby text="��"]�ꡢ[l][font shadow=false edge=true edgecolor=0xff0000]�Fȡ�����֤ˤ�����[resetfont]��[l][r]
[style align=center]���󥿥�󥰤��Ƥߤ���[r]
[style align=right]��ԑ�ᤷ�Ƥߤ���[r][resetstyle]
[l]
[graph storage="ExQuestion.png" alt="!?"]�Τ褦������ӛ�Ť��ʾ���Ƥߤ��ꡢ[l][r]
�ȡ�������Ǥ��ޤ���[p]
*about_kag4|
@position vertical=true
���ޤ����k������ʾ�򤹤뤳�Ȥ�Ǥ��ޤ���[l][r]
���k�����Ǥ�������ȫ��ͬ���C�ܤ�ʹ�ä��뤳�Ȥ��Ǥ��ޤ���[p]
@layopt layer=message0 visible=false
@layopt layer=message1 visible=true
@current layer=message1
@position frame=messageframe left=20 top=280 marginl=16 margint=16 marginr=0 marginb=16 draggable=true vertical=false
�����Τ褦�˥�å��`�������Ф˥�å��`�����ʾ�����뤳�Ȥ�Ǥ��ޤ���[l]���ɥ٥����`���`����������륿���פǤ���[p]
@layopt layer=message1 visible=false
@layopt layer=message0 visible=true
@current layer=message0
@position vertical=false
*about_kag5|
@cm
�������}�Ϥ��Τ褦��(��������餺[ruby text="?"]��[ruby text="?"]�ˤǤ��ߤޤ���)
@backlay
@image storage=uni page=back layer=0 visible=true opacity=255
@trans method=crossfade time=1000
@wt
����ե��֥��ɤˤ���ؤͺϤ碌�����ܤǤ���[l][r]
�����Τ褦��
@backlay
@layopt page=back layer=0 opacity=128
@trans method=crossfade time=1000
@wt
������ʾ���뤳�Ȥ�Ǥ��ޤ���[l][r]
���˜ʤ�״�B�ǣ��Ĥޤ��ؤͺϤ碌�Ʊ�ʾ�Ǥ��ޤ���[p]
@backlay
@layopt page=back layer=0 visible=false
@trans method=crossfade time=300
@wt
*about_kag6|
@cm
���ȥ�󥸥����(�����Ф��椨)�ˤϘ˜ʤǣ��ĤηN�����ޤ���[l][r]
��һ�Ĥυg���ʥ����ե��`�ɡ�[l]
@backlay
@layopt page=back layer=message0 visible=false
@trans method=crossfade time=300
@wt
@backlay
@image storage="_24" page=back layer=base
@trans method=crossfade time=3000
@wt
@backlay
@image storage="_24_4" page=back layer=base
@trans method=crossfade time=3000
@wt
@backlay
@layopt page=back layer=message0 visible=true
@trans method=crossfade time=300
@wt
[l][r]
���⤦һ�Ĥϥ�����`�넿����������ȤΤǤ��륹����`��ȥ�󥸥����[l]
@backlay
@layopt page=back layer=message0 visible=false
@trans method=crossfade time=300
@wt
@backlay
@image storage="_24" page=back layer=base
@trans method=scroll from=right stay=stayfore time=3000
@wt
@backlay
@image storage="_24_4" page=back layer=base
@trans method=scroll from=bottom stay=nostay time=3000
@wt
@backlay
@layopt page=back layer=message0 visible=true
@trans method=crossfade time=300
@wt
[l][r]
������������������ߤ����ɤ˥ѥ��`������ɤǤ����˥Щ`����ȥ�󥸥����Ǥ���[l][r]
����˥Щ`����ȥ�󥸥����ϥ�`�뻭��Ⱥ��Ф�륰��`�����`��λ�������⤷�����λ���ΰ����Ȥ��������礯�Ф��椨��ʼ�ޤ��ΤǤ���[l][r]
�����Ȥ��С�[l]
@image layer=base page=fore storage="trans1"
���Τ褦�ʥ�`�뻭��Ǥ����???[l]
@backlay
@layopt page=back layer=message0 visible=false
@image storage="_24_4" page=back layer=base
@trans method=crossfade time=300
@wt
@backlay
@image storage="_24" page=back layer=base
@trans method=universal rule="trans1" vague=64 time=3000
@wt
@backlay
@image storage="_24_4" page=back layer=base
@trans method=universal rule="trans1" vague=64 time=3000
@wt
@backlay
@layopt page=back layer=message0 visible=true
@trans method=crossfade time=300
@wt
[r]
�����Ȥ��С�[l]
@image layer=base page=fore storage="nami"
���Τ褦�ʥ�`�뻭��Ǥ����???[l]
@backlay
@layopt page=back layer=message0 visible=false
@image storage="_24_4" page=back layer=base
@trans method=crossfade time=300
@wt
@backlay
@image storage="_24" page=back layer=base
@trans method=universal rule="nami" vague=64 time=3000
@wt
@backlay
@image storage="_24_4" page=back layer=base
@trans method=universal rule="nami" vague=64 time=3000
@wt
@backlay
@layopt page=back layer=message0 visible=true
@trans method=crossfade time=300
@wt
[r]
���Ȥ����Ф��ǡ����������뤳�Ȥ��Ǥ��ޤ���[p]
*about_kag7|KAG�Ȥ�
@cm
��BGM�Ȥ��Ƥ�CD-DA��MIDI��PCM�Τ����줫��ʹ�äǤ��ޤ���[l]�������ˤ�PCM��ʹ�äǤ��ޤ���[l]�������ե��`�ɤʤɤ������������Ǥ��ޤ���[l][r]
��PCM�Ϙ˜ʤǟo�R�s��.WAV�������Ǥ��ޤ���[l]�ޤ����ץ饰������������ܤ���ʽ�򒈏��Ǥ���OggVorbis�������Ǥ��ޤ���[l][r]
����`�ө`��AVI/MPEG/SWF�������Ǥ��ޤ���[p]
*about_kag8|
@cm
��KAG�Ή����������ФǤ������Ǥ����뤳�Ȥ��Ǥ������������ϟo���ޡ������Ф��L����o���ޡ����������������Ǥʤ��g����Q�����Ȥ��Ǥ��ޤ���[l]�����KAG�Ή������˘��Ȥ�������KAG�Υ٩`���ȤʤäƤ���TJS���˘��Ǥ���[l][r]
�������ˤϥ��`�������ȥ����ƥ������Σ��N��äơ����`�������ϖݤȤȤ���i���z�ޤ줿�걣�椵�줿�ꤷ�ޤ����������ƥ������ϖݤȤ��v�S�ʤ�������ͬ�����ݤ򱣤Ĥ��Ȥ��Ǥ����ΤǤ���[l][r]
��������ʹ�ä�����ʾ���ޤ�???[p]
@eval exp="f.v1 = intrandom(1, 9)"
@eval exp="f.v2 = intrandom(1, 9)"
@eval exp="f.ans = f.v1 * f.v2"
@eval exp="f.input = ''"
*about_kag_var_0|Ӌ�㆖�}
@cm
��Ӌ�㆖�}�Ǥ���[emb exp="f.v1"] �� [emb exp="f.v2"] �ϣ�[r]
[font size=20](�¤������ڤ����������顢�褳�Ρ�OK���򥯥�å����Ƥ�������)[resetfont][r]
[r]
@start_select
��[edit name="f.input" length=200 opacity=80 bgcolor=0x000000 color=0xffffff] [link target=*about_kag_var_1]������OK������[endlink][r]
[r]
��[link target=*about_kag_9]�浹�ʤΤǤȤФ�[endlink]
@end_select
@eval exp="kag.fore.messages[0].links[0].object.focus()"
; �������ڤ˥ե��`�������O������
; �������ƥ� - ǰ�ˑ��롹�Ǥ���λ�äˑ����褦�ˤ�����ͨ�^ӛ�h���Ф�
@record
[s]

*about_kag_var_1
@commit
@jump cond="str2num(f.input) == f.ans" target=*about_kag_var_correct
@cm
�������⣡[l][r]
���⤦һ���������Ƥ���������[p]
@jump target=*about_kag_var_0

*about_kag_var_correct
@cm
������Ǥ���[p]
@jump target=*about_kag_9

*about_kag_9|
@cm
@snowinit forevisible=true backvisible=false
��KAG�δ󤭤��؏դȤ��ơ����θߤ������Ԥȥ������ޥ����Ԥ��������ޤ���[l]KAG�����Ǥόg�F�Ǥ��ʤ��褦�ʙC�ܤ⡢TJS��ʹ�ä�ֱ�Ӽ��Ｊ�����������Ф�������¤��Ǥ��ޤ���[l][r]
�����Ȥ��С�KAG�åץ饰����Ȥ��ơ�ѩ�����ʾ������ץ饰������i���z��С����Τ褦��ѩ���ʾ�����뤳�Ȥ��Ǥ��ޤ���[l]�ۤ��ˤ�ȥ�󥸥����ηN򉈤䤹�ץ饰����ʤɤ�����ޤ���[l][r]
���ޤ���KAG���Τ�Τ�TJS������ץȤǕ�����Ƥ��뤿�ᡢ������ץȤ���������硩�ˤ錄�äƄ����򥫥����ޥ��������¤��Ǥ��ޤ���[p]
@backlay
@snowopt backvisible=false
@trans method=crossfade time=1000
@wt
@snowuninit
*about_kag_fin|KAG�νB�餪���ޤ�
@cm
��KAG�νB��Ϥ���Ǥ����ޤ��Ǥ���[l][r]
���ߤʤ�����ǷǼ��Ｊ��/KAG��ʹ�äƤ��Ф餷�����`������äƤ���������[l][r]
[r]
@start_select
[link exp="System.shellExecute('http://www.piass.com/kpc/')" hint="���Ｊ��/KAG���Mί�T����_���ޤ�"]���Ｊ��/KAG���Mί�T��[endlink][r]
[link exp="System.shellExecute('http://kikyou.info/tvp/')" hint="�������`�ɥک`�����_���ޤ�"]���Ｊ��������`�ɥک`��[endlink][r]
[r]
[link target=*to_syokai_start]��˥�`�ˑ���[endlink]
@end_select
[s]
