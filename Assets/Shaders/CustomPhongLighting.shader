Shader "Diplomado/CustomPhongLighting"
{
	Properties
	{
		_MainTex("Textura", 2D) = "white" {}
		_TintColor("Tinta", Color) = (1,1,1,1)
		_SpecularColor("Color Especular", Color) = (1,1,1,1)
		_SpecPower("Potencia Especular", Range(0,30)) = 1
	}
		SubShader
		{
			CGPROGRAM
			#pragma surface surf MyPhong
			sampler2D _MainTex;
		float _SpecPower;
		float4 _TintColor;
		float4 _SpecularColor;
		struct Input {
			float2 uv_MainTex;
		};
		inline fixed4 LightingMyPhong(SurfaceOutput s, 
									  fixed3 lightDir, 
									  half3 viewDir, 
									  fixed atten){
		
			float diff = dot(s.Normal, lightDir);
			float3 reflectionVector = normalize(2.0 * s.Normal * diff - lightDir);
			float spec = pow(max(0, dot(reflectionVector, viewDir)), _SpecPower);
			float3 finalSpec = _SpecularColor * spec;
			fixed4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * 2.0 * diff * atten) +
					(_LightColor0.rgb * finalSpec);
			c.a = 1.0;

			return c;
		}

		void surf(Input IN, inout SurfaceOutput o) {
			
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Specular = _SpecPower;
			o.Gloss = 1.0;
			o.Albedo = c.rgb * _TintColor.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}
