﻿Shader "Diplomado/RampTextureLighting"
{
	Properties
	{
		_MainTex ("Base", 2D) = "white" {}
		_RampTex("Ramp", 2D) = "white" {}
	}
		SubShader
	{
		CGPROGRAM
		#pragma surface surf BasicDiffuse
		sampler2D _MainTex;
		sampler2D _RampTex;
		struct Input {
			float2 uv_MainTex;
		};
		inline float4 LightingBasicDiffuse(SurfaceOutput s,
										   fixed3 lightDir,
										   fixed atten) {
			float diffLight = max(0, dot(s.Normal, lightDir));
			float hLambert = diffLight*0.5 + 0.5;
			float3 ramp = tex2D(_RampTex, float2(hLambert, hLambert)).rgb;
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * ramp;
			col.a = s.Alpha;
			return col;
		
		}
		void surf(Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG

	}

	Fallback "Diffuse"
}
