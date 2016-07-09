Shader "Diplomado/PhongLighting"
{
	Properties
	{
		_MainTex ("Textura", 2D) = "white" {}
		_TintColor ("Tinta", Color) = (1,1,1,1)
		_SpecularColor("Color Especular", Color) = (1,1,1,1)
		_SpecPower("Potencia Especular", Range(0,1)) = 0.5
	}
	
	SubShader
	{
		CGPROGRAM
		#pragma surface surf BlinnPhong
		sampler2D _MainTex;
		float4 _TintColor;
		float4 _SpecularColor;
		float _SpecPower;
		struct Input{
			float2 uv_MainTex;
		};
		void surf(Input IN, inout SurfaceOutput o){
	
			half4 c = tex2D(_MainTex, IN.uv_MainTex) * _TintColor;
			o.Specular = _SpecPower;
			o.Gloss = 1.0;
			o.Albedo = c.rgb;
			o.Alpha = c.a;

		}
		ENDCG

	}
	Fallback "Diffuse"
}
