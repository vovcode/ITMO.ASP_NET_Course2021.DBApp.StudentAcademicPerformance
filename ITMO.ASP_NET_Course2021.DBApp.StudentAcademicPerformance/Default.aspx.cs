using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITMO.ASP_NET_Course2021.DBApp.StudentAcademicPerformance
{
    public partial class Default : System.Web.UI.Page
    {
        SqlConnection sqlConnection = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\StudentInfo.mdf;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)//Действия при загрузке страницы
            {
                btnDelete.Enabled = false;
                FillGridView();
            }  
        }
        protected void btnClear_Click(object sender, EventArgs e)//Кнопка очистки полей ввода от информации
        {
            Clear();
        }
        void FillGridView()//Заполнение Grid View данными из базы
        {
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("StudentInfoViewAll", sqlConnection);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlConnection.Close();
            StudInfoGV.DataSource = dtbl;
            StudInfoGV.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)//Кнопка сохранения информации о студенте, включая случай внесения изменений в ранее существующую запись
        {
            string grades; //Переменная будет содежать строку оценок студента
            double avgMark; //Переменная будет содержать средний балл студента
            int totalMarkWeight; ///Переменная будет общее колличество баллов студента
            int twos, threes, fours, fives; //Переменные содержащие количество "двоек", "троек", "четверок", "пятерок" студента

            grades = txtGrades.Text;
            twos = MarkEntityTwoCounter(grades, StringContentChecker(grades));
            threes = MarkEntityThreeCounter(grades, StringContentChecker(grades));
            fours = MarkEntityFourCounter(grades, StringContentChecker(grades));
            fives = MarkEntityFiveCounter(grades, StringContentChecker(grades));
            avgMark = AverageMark(twos, threes, fours, fives);
            totalMarkWeight = TotalMarkWeight(twos, threes, fours, fives);

            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand("StudentCreateOrUpdate", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@StudentId", (hStudentId.Value == "" ?0:Convert.ToInt32(hStudentId.Value)));
            sqlCommand.Parameters.AddWithValue("@FullName",txtFullName.Text.Trim());
            sqlCommand.Parameters.AddWithValue("@ResultString",txtGrades.Text.Trim());
            sqlCommand.Parameters.AddWithValue("@GPA", avgMark);
            sqlCommand.Parameters.AddWithValue("@TotalScore", totalMarkWeight);
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
            string studentID = hStudentId.Value;
            Clear();
            if (studentID == "")
                lblSuccessMsg.Text = "Запись сохранена успешно";
            else
                lblSuccessMsg.Text = "Запись обновлена успешно";
            FillGridView();
        }
        protected void btnDelete_Click(object sender, EventArgs e)//Кнопка удаления записи о студенте
        {
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();
            SqlCommand sqlCmd = new SqlCommand("StudentDeleteById",sqlConnection);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@StudentId",Convert.ToInt32(hStudentId.Value));
            sqlCmd.ExecuteNonQuery();
            sqlConnection.Close();
            Clear();
            FillGridView();
            lblSuccessMsg.Text = "Запись удалена успешно";
        }
        public void Clear()//Очистка полей ввода от информации
        {
            hStudentId.Value = "";
            txtFullName.Text = txtGrades.Text = "";
            lblSuccessMsg.Text = lblErrorMsg.Text = "";
            btnSave.Text = "Сохранить";
            btnDelete.Enabled = false;
        }
        protected void lnk_OnClick(object sender, EventArgs e) //По нажатии на ЭУ Link Button напротив ряда Grid View выводит соответствующую информацию о студенте в текстовые поля ввода
        {
            int studentId = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlConnection.State == ConnectionState.Closed)
                sqlConnection.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("StudentViewByID", sqlConnection);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@StudentId", studentId);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlConnection.Close();
            hStudentId.Value = studentId.ToString();
            txtFullName.Text = dtbl.Rows[0]["FullName"].ToString();
            txtGrades.Text = dtbl.Rows[0]["ResultString"].ToString();
            btnSave.Text = "Обновить";
            btnDelete.Enabled = true;
        }


        //Проверка содержимого строки "Оценки за период обучения" на недопустимый ввод (символы, буквы, пробел)
        public static bool StringContentChecker(string str) //Возвращает true, если в строке нет символов, букв или пробела
        {
            if (str.Any(x => !char.IsLetterOrDigit(x)) || str.Any(x => char.IsLetter(x)))
                return false;
            else
                return true;
        }
        /*-------------------------------------------------------------------------------------------------------------------------------------------
         -------------------------------------------------------------------------------------------------------------------------------------------*/
        //Ниже методы разложения строки, содержащей ряд оценок, на составляющие
        public static int MarkEntityTwoCounter(string markseq, bool istrue) //Возвращает количество "двоек" у студента, при их отсутствии 0
        {
            if (istrue)
            {
                int twocount;
                twocount = markseq.Length - markseq.Replace("2", "").Length;
                return twocount;
            }
            else
            {
                return 0;
            }
        }
        public static int MarkEntityThreeCounter(string markseq, bool istrue) //Возвращает количество "троек" у студента, при их отсутствии 0
        {
            if (istrue)
            {
                int threecount;
                threecount = markseq.Length - markseq.Replace("3", "").Length;
                return threecount;
            }
            else
            {
                return 0;
            }
        }
        public static int MarkEntityFourCounter(string markseq, bool istrue) //Возвращает количество "четверок" у студента, при их отсутствии 0
        {
            if (istrue)
            {
                int fourcount;
                fourcount = markseq.Length - markseq.Replace("4", "").Length;
                return fourcount;
            }
            else
            {
                return 0;
            }
        }
        public static int MarkEntityFiveCounter(string markseq, bool istrue) //Возвращает количество "пятерок" у студента, при их отсутствии 0
        {
            if (istrue)
            {
                int fivecount;
                fivecount = markseq.Length - markseq.Replace("5", "").Length;
                return fivecount;
            }
            else
            {
                return 0;
            }
        }
        /*-------------------------------------------------------------------------------------------------------------------------------------------
         -------------------------------------------------------------------------------------------------------------------------------------------*/
        public static double AverageMark(int twos, int threes, int fours, int fives) //Возвращает средний балл студента, расчитанный исходя из оценок за период обучения
        {
            double avgMark; //Высчитываемое и возвращаемое методом значение средней оценки ученика
            double entityCounter; //Количество отметок студента
            entityCounter = twos + threes + fours + fives;
            double entityTotalWeight;
            entityTotalWeight = (twos * 2) + (threes * 3) + (fours * 4) + (fives * 5); //Общее количество баллов студента
            avgMark = Math.Round((entityTotalWeight / entityCounter), 2);//Округление среднего балла до сотых
            return avgMark;
        }
        public static int TotalMarkWeight(int twos, int threes, int fours, int fives)//Возвращает общее количество баллов студента  исходя из оценок за период обучения
        {
            int totalMarkWeight;
            totalMarkWeight = (twos * 2) + (threes * 3) + (fours * 4) + (fives * 5); //Общее количество баллов студента
            return totalMarkWeight;
        }
    }
}