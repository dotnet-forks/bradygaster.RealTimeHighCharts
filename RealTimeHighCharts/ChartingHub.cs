using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Timers;

namespace RealTimeHighCharts
{
    public class ChartingHub : Hub
    {
        Timer _timer;

        public override System.Threading.Tasks.Task OnConnected()
        {
            if (_timer == null)
            {
                _timer = new Timer(5000);
                _timer.Elapsed += (sender, e) =>
                    {
                        Clients.All.updateChart(new ChartBit
                            {
                                Answer1 = GetRandomInt(),
                                Answer2 = GetRandomInt(),
                                Answer3 = GetRandomInt(),
                                Answer4 = GetRandomInt(),
                                Answer5 = GetRandomInt(),
                                Feedback = "This is feedback",
                                PresentationCode = "001",
                                QuestionCode = "002"
                            });
                    };
                _timer.Start();
            }

            return base.OnConnected();
        }

        private int GetRandomInt()
        {
            return new Random(Environment.TickCount).Next(1, 100);
        }
    }

    public class ChartBit
    {
        public string PresentationCode { get; set; }
        public string QuestionCode { get; set; }
        public int Answer1 { get; set; }
        public int Answer2 { get; set; }
        public int Answer3 { get; set; }
        public int Answer4 { get; set; }
        public int Answer5 { get; set; }
        public string Feedback { get; set; }
    }
}