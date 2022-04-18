precision highp float;
uniform float time;
uniform vec2 resolution;

float circles(vec2 p)
{
  float ret = 0.0;
  
  ret = mod(distance(p,vec2(0.0)), .1);
  
  return ret;
}

float func(vec2 p)
{
  float ret = 0.0;
  ret = circles(p/(p.y));
  ret -= circles(vec2(p.x-.5, p.y-.5));
  ret -= circles(vec2(p.x+.5, p.y+.5));
  ret -= circles(vec2(p.x-.5, p.y+.5));
  ret -= circles(vec2(p.x+.5, p.y-.5));
  ret *= cos(time/clamp(ret, -.19, -.1)*.5);
  ret /= 1.0-distance(p, vec2(0.0));
  
  return ret;
}

void main()
{
  vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
  uv*=2.0;
  vec3 col = vec3(1.0);
  
  col = vec3(func(uv));

  gl_FragColor = vec4(col,1.0);
}