// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33042,y:32792,varname:node_3138,prsc:2|emission-8870-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32541,y:33047,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3291075,c2:1,c3:0.007352948,c4:1;n:type:ShaderForge.SFN_Tex2d,id:8920,x:32567,y:32833,ptovrint:False,ptlb:node_8920,ptin:_node_8920,varname:_node_8920,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3e0d1d70886ca411a8d845638807b180,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:8870,x:32887,y:32978,varname:node_8870,prsc:2|A-8920-RGB,B-7241-RGB,T-4565-OUT;n:type:ShaderForge.SFN_Time,id:3030,x:32557,y:33229,varname:node_3030,prsc:2;n:type:ShaderForge.SFN_RemapRange,id:3174,x:32875,y:33282,varname:node_3174,prsc:2,frmn:-1,frmx:1,tomn:-3,tomx:3|IN-6759-OUT;n:type:ShaderForge.SFN_Sin,id:6759,x:32719,y:33312,varname:node_6759,prsc:2|IN-3030-TDB;n:type:ShaderForge.SFN_Color,id:6770,x:32825,y:33505,ptovrint:False,ptlb:node_6770,ptin:_node_6770,varname:_node_6770,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.02941179,c3:0.02941179,c4:1;n:type:ShaderForge.SFN_Multiply,id:4565,x:33091,y:33358,varname:node_4565,prsc:2|A-3174-OUT,B-6770-RGB;proporder:7241-8920-6770;pass:END;sub:END;*/

Shader "Shader Forge/lerptest" {
    Properties {
        _Color ("Color", Color) = (0.3291075,1,0.007352948,1)
        _node_8920 ("node_8920", 2D) = "white" {}
        _node_6770 ("node_6770", Color) = (1,0.02941179,0.02941179,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _node_8920; uniform float4 _node_8920_ST;
            uniform float4 _node_6770;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _node_8920_var = tex2D(_node_8920,TRANSFORM_TEX(i.uv0, _node_8920));
                float4 node_3030 = _Time + _TimeEditor;
                float3 emissive = lerp(_node_8920_var.rgb,_Color.rgb,((sin(node_3030.b)*3.0+0.0)*_node_6770.rgb));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
