using ORM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BaseQuestion
/// </summary>
public abstract class BaseQuestion
{
    public bool _question_active=true;
    public String _question_ID = "";
    public String _description = "";
    public String _form_ID = "";
    public Boolean _question_optional = true;
    public Question_Type _question_type = Question_Type.Text;
    public Template_Type _template_type = Template_Type.Manual;
    public int _question_index = 0;
    public ORM.List _list = null;
    public Int64 _question_pre = 0;
    public String _relation_condition = "null";
    public SQL_Connector _CN = new SQL_Connector();

    public bool Question_active
    {
        get { return _question_active; }
        set { _question_active = value; }
    }
    public String Question_ID
    {
        get { return _question_ID; }
        set { _question_ID = value; }
    }

    public String Description
    {
        get { return _description; }
        set { _description = value; }
    }

    public String Form_ID
    {
        get { return _form_ID; }
        set { _form_ID = value; }
    }

    public Boolean Question_Optional
    {
        get { return _question_optional; }
        set { _question_optional = value; }
    }

    public Question_Type Question_Type
    {
        get { return _question_type; }
        set { _question_type = value; }
    }

    public Template_Type Template_Type
    {
        get { return _template_type; }
        set { _template_type = value; }
    }

    public int Question_Index
    {
        get { return _question_index; }
        set { _question_index = value; }
    }

    public ORM.List List
    {
        get { return _list; }
        set { _list = value; }
    }
    public String Relation_Question
    {
        get { return _relation_condition; }
        set { _relation_condition = value; }
    }
    public Int64 Question_PreID
    {
        get { return _question_pre; }
        set { _question_pre = value; }
    }
}