import java.lang.reflect.Method;

public class Inspector {
  public static void inspectObject(Object o) {
    Class c = o.getClass();
    for (Method m : c.getDeclaredMethods()) {
      System.out.println("Method " + m.getName() + " found!");
    }
  }
}
