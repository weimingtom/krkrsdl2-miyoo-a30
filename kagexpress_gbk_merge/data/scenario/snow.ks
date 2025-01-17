@if exp="typeof(global.snow_object) == 'undefined'"
@iscript

/*
	僣をふらせるプラグイン
*/

class SnowGrain
{
	// 僣腺のクラス

	var fore; // 燕鮫中の僣腺オブジェクト
	var back; // �Y鮫中の僣腺オブジェクト
	var xvelo; // 罪堀業
	var yvelo; // �k堀業
	var xaccel; // 罪紗堀
	var l, t; // 罪了崔と�k了崔
	var ownwer; // このオブジェクトを侭嗤する SnowPlugin オブジェクト
	var spawned = false; // 僣腺が竃�Fしているか
	var window; // ウィンドウオブジェクトへの歌孚

	function SnowGrain(window, n, owner)
	{
		// SnowGrain コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.absolute = 2000000-1; // 嶷ね栽わせ��會はメッセ�`ジ堕�sよりも安
		back.absolute = fore.absolute;

		fore.hitType = htMask;
		fore.hitThreshold = 256; // マウスメッセ�`ジは畠囃邑�^
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("snow_" + n); // 鮫�颪鰌iみ�zむ
		back.assignImages(fore);
		fore.setSizeToImageSize(); // レイヤのサイズを鮫�颪離汽ぅ困藩�じに
		back.setSizeToImageSize();
		xvelo = 0; // 罪圭�鯔拔�
		yvelo = n*0.6 + 1.9 + Math.random() * 0.2; // �k圭�鯔拔�
		xaccel = Math.random(); // 兜豚紗堀業
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn()
	{
		// 竃�F
		l = Math.random() * window.primaryLayer.width; // 罪兜豚了崔
		t = -fore.height; // �k兜豚了崔
		spawned = true;
		fore.setPos(l, t);
		back.setPos(l, t); // �Y鮫中の了崔も揖じに
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function resetVisibleState()
	{
		// 燕幣?掲燕幣の彜�Bを壅�O協する
		if(spawned)
		{
			fore.visible = owner.foreVisible;
			back.visible = owner.backVisible;
		}
		else
		{
			fore.visible = false;
			back.visible = false;
		}
	}

	function move()
	{
		// 僣腺を�咾�す
		if(!spawned)
		{
			// 竃�Fしていないので竃�Fする�C氏をうかがう
			if(Math.random() < 0.002) spawn();
		}
		else
		{
			l += xvelo;
			t += yvelo;
			xvelo += xaccel;
			xaccel += (Math.random() - 0.5) * 0.3;
			if(xvelo>=1.5) xvelo=1.5;
			if(xvelo<=-1.5) xvelo=-1.5;
			if(xaccel>=0.2) xaccel=0.2;
			if(xaccel<=-0.2) xaccel=-0.2;
			if(t >= window.primaryLayer.height)
			{
				t = -fore.height;
				l = Math.random() * window.primaryLayer.width;
			}
			fore.setPos(l, t);
			back.setPos(l, t); // �Y鮫中の了崔も揖じに
		}
	}

	function exchangeForeBack()
	{
		// 燕と�Yの砿尖秤�鵑鮟��Qする
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class SnowPlugin extends KAGPlugin
{
	// 僣を尅らすプラグインクラス

	var snows = []; // 僣腺
	var timer; // タイマ
	var window; // ウィンドウへの歌孚
	var foreVisible = true; // 燕鮫中が燕幣彜�Bかどうか
	var backVisible = true; // �Y鮫中が燕幣彜�Bかどうか

	function SnowPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの砿尖するすべてのオブジェクトを苧幣議に篤��
		for(var i = 0; i < snows.count; i++)
			invalidate snows[i];
		invalidate snows;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		// num ��の僣腺を竃�Fさせる
		if(timer !== void) return; // すでに僣腺はでている

		// 僣腺を恬撹
		for(var i = 0; i < num; i++)
		{
			var n = intrandom(0, 4); // 僣腺の寄きさ ( ランダム )
			snows[i] = new SnowGrain(window, n, this);
		}
		snows[0].spawn(); // 恷兜の僣腺だけは恷兜から燕幣

		// タイマ�`を恬撹
		timer = new Timer(onTimer, '');
		timer.interval = 80;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		setOptions(options); // オプションを�O協
	}

	function uninit()
	{
		// 僣腺を��す
		if(timer === void) return; // 僣腺はでていない

		for(var i = 0; i < snows.count; i++)
			invalidate snows[i];
		snows.count = 0;

		invalidate timer;
		timer = void;
	}

	function setOptions(elm)
	{
		// オプションを�O協する
		foreVisible = +elm.forevisible if elm.forevisible !== void;
		backVisible = +elm.backvisible if elm.backvisible !== void;
		resetVisibleState();
	}

	function onTimer()
	{
		// タイマ�`の巓豚ごとに柵ばれる
		var snowcount = snows.count;
		for(var i = 0; i < snowcount; i++)
			snows[i].move(); // move メソッドを柵び竃す
	}

	function resetVisibleState()
	{
		// すべての僣腺の 燕幣?掲燕幣の彜�Bを壅�O協する
		var snowcount = snows.count;
		for(var i = 0; i < snowcount; i++)
			snows[i].resetVisibleState(); // resetVisibleState メソッドを柵び竃す
	}

	function onStore(f, elm)
	{
		// �櫃魃４罎垢襪箸�
		var dic = f.snows = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.snowCount = snows.count;
	}

	function onRestore(f, clear, elm)
	{
		// �櫃鰌iみ竃すとき
		var dic = f.snows;
		if(dic === void || !+dic.init)
		{
			// 僣はでていない
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 僣はでていた
			init(dic.snowCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible ] );
		}
	}

	function onStableStateChanged(stable)
	{
	}

	function onMessageHiddenStateChanged(hidden)
	{
	}

	function onCopyLayer(toback)
	{
		// レイヤの燕○★�Y秤�鵑離灰圦`
		// このプラグインではコピ�`すべき秤�鵑榔輅�?掲燕幣の秤�鵑世�
		if(toback)
		{
			// 燕★�Y
			backVisible = foreVisible;
		}
		else
		{
			// �Y★燕
			foreVisible = backVisible;
		}
		resetVisibleState();
	}

	function onExchangeForeBack()
	{
		// �Yと燕の砿尖秤�鵑鮟��Q
		var snowcount = snows.count;
		for(var i = 0; i < snowcount; i++)
			snows[i].exchangeForeBack(); // exchangeForeBack メソッドを柵び竃す
	}
}

kag.addPlugin(global.snow_object = new SnowPlugin(kag));
	// プラグインオブジェクトを恬撹し、鞠�hする

@endscript
@endif
; マクロ鞠�h
@macro name="snowinit"
@eval exp="snow_object.init(17, mp)"
@endmacro
@macro name="snowuninit"
@eval exp="snow_object.uninit()"
@endmacro
@macro name="snowopt"
@eval exp="snow_object.setOptions(mp)"
@endmacro
@return
