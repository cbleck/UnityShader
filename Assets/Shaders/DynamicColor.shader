// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Diplomado/DynamicColor"
{
	Properties{
		_UpColor("Color Arriba", Color) = (1,1,1,1)
		_DownColor("Color Abajo", Color) = (1,1,1,1)
	}
		SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4 _UpColor;
			float4 _DownColor;
			
			struct appdata {
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
			};

			v2f vert(appdata v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				float4 cPos = mul(unity_ObjectToWorld, v.vertex);
				if (cPos.y >= 0)
					o.color.rgb = _UpColor.rgb;
				else
					o.color.rgb = _DownColor.rgb;
				o.color.w = 1.0;
				return o;
			}

			fixed4 frag(v2f i) : COLOR{
				
				return i.color;
			}

			ENDCG
		}
	}
	Fallback "Diffuse"
}
