package util

/**
 * Created by IntelliJ IDEA.
 * User: remo
 * Date: 16.06.2010
 * Time: 19:19:47
 * To change this template use File | Settings | File Templates.
 */
import java.util.Date
import java.text.SimpleDateFormat
import org.springframework.beans.propertyeditors.CustomDateEditor
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry

public class CustomPropertyEditorRegistrar implements PropertyEditorRegistrar {
  public void registerCustomEditors(PropertyEditorRegistry registry) {
      registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("dd.MM.yyyy"), true));
  }
} 
