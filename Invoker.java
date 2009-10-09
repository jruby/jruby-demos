import java.lang.reflect.Method;

public class Invoker {
  public static void invokeMethod(Object o, String name) {
    Class c = o.getClass();
    try {
        Method m = c.getDeclaredMethod(name);
        m.invoke(o);
    } catch (Exception e) {}
  }
}
