import ContextMapper.MyUserDetailsContextMapper

// Place your Spring DSL code here
beans = {
  customPropertyEditorRegistrar(util.CustomPropertyEditorRegistrar)

  UserDetailsContextMapper(MyUserDetailsContextMapper)

}