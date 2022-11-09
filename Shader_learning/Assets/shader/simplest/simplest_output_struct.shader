// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/simplest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color",Color)=(1,1,1,1)
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

            // a variable in CGPROGRAM can be used only it is defined before in Properties  
            fixed4 _Color;

            //a application to vertex
            struct a2v
            {
                //using model vertex to assign v
                float4 vertex:POSITION;
                //using model normal to assign n
                float3 normal:NORMAL;
                //using model first uv to assign texcoord
                float4 texcoord:TEXCOORD0;
            };


            //vertex to frag
            struct v2f
            {
                //SV_POSITION: pos is the position information of clip space
                float4 pos:SV_POSITION;
                //COLOR0: color stores color information
                fixed3 color:COLOR0;

            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                //let (-1,1) scope change to (0,1)
                o.color = v.normal*0.5 + fixed3(0.5,0.5,0.5);
                return o;
            }
             
            float4 frag(v2f i):SV_TARGET
            {
                fixed3 c = i.color; 
                c*=_Color.rgb;
                return fixed4(c,1);
            }  
            ENDCG
        }
    }
}
