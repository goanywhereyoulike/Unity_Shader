// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/simplest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct a2v
            {
                //using model vertex to assign v
                float4 v:POSITION;
                //using model normal to assign n
                float3 n:NORMAL;
                //using model first uv to assign texcoord
                float4 texcoord:TEXCOORD0;
            };

            float4 vert(a2v v):SV_POSITION
            {
                return UnityObjectToClipPos(v.v);
            }
             
            float4 frag():SV_TARGET
            {
                return fixed4(1,1,1,1);
            }  
            ENDCG
        }
    }
}
